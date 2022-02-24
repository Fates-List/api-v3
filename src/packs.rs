// Endpoints to create, delete and edit packs
use actix_web::{HttpRequest, post, patch, delete, web, HttpResponse, ResponseError};
use actix_web::http::header::HeaderValue;
use crate::models;
use log::error;

async fn pack_check(data: &models::AppState, pack: &mut models::BotPack) -> Result<(), models::PackCheckError> {
    // Resolve the bot pack
    if pack.resolved_bots.len() > 7 {
        return Err(models::PackCheckError::TooManyBots);
    }

    if pack.description.len() < 10 {
        return Err(models::PackCheckError::DescriptionTooShort);
    }

    let mut bots = Vec::new();
    for bot in &pack.resolved_bots {
        let parsed_id = bot.user.id.parse::<i64>();
        if parsed_id.is_err() {
            return Err(models::PackCheckError::InvalidBotId);
        }
        bots.push(parsed_id.unwrap())
    }
    // Resolve bots
    pack.resolved_bots = data.database.resolve_pack_bots(bots).await;

    if pack.resolved_bots.len() < 2 {
        return Err(models::PackCheckError::TooFewBots);
    }

    // Possibly readd pack limits if people abuse packs?
    if !pack.icon.is_empty() && !pack.icon.starts_with("https://") {
        return Err(models::PackCheckError::InvalidIcon);
    }

    if !pack.icon.is_empty() && !pack.icon.starts_with("https://") {
        return Err(models::PackCheckError::InvalidBanner);
    }

    Ok(())
}


#[post("/users/{id}/packs")]
async fn add_pack(req: HttpRequest, info: web::Path<models::FetchBotPath>, mut pack: web::Json<models::BotPack>) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    let user_id = info.id;

    // Check auth
    let auth_default = &HeaderValue::from_str("").unwrap();
    let auth = req.headers().get("Authorization").unwrap_or(auth_default).to_str().unwrap();
    if !data.database.authorize_user(user_id, auth).await {
        error!("Pack Add Auth error");
        return models::CustomError::ForbiddenGeneric.error_response();
    }

    pack.owner.id = user_id.to_string();

    let mut pack = pack.into_inner();

    let res = pack_check(data, &mut pack).await;

    if res.is_err() {
        return HttpResponse::BadRequest().json(models::APIResponse {
            done: false,
            reason: Some(res.unwrap_err().to_string()),
            context: Some("Add pack error".to_string())
        });
    }

    let res = data.database.add_pack(pack).await;

    if res.is_err() {
        return HttpResponse::BadRequest().json(models::APIResponse {
            done: false,
            reason: Some(res.unwrap_err().to_string()),
            context: Some("Add pack error".to_string())
        });
    }

    return HttpResponse::Ok().json(models::APIResponse {
        done: true,
        reason: Some("Added bot pack successfully!".to_string()),
        context: None
    });
}

#[patch("/users/{id}/packs")]
async fn edit_pack(req: HttpRequest, info: web::Path<models::FetchBotPath>, pack: web::Json<models::BotPack>) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    let user_id = info.id;

    // Check auth
    let auth_default = &HeaderValue::from_str("").unwrap();
    let auth = req.headers().get("Authorization").unwrap_or(auth_default).to_str().unwrap();
    if !data.database.authorize_user(user_id, auth).await {
        error!("Pack Edit Auth error");
        return models::CustomError::ForbiddenGeneric.error_response();
    }

    // Make sure we are the owner of this pack
    let pack_owners = data.database.get_pack_owners(pack.id.clone()).await;

    if let Some(owner) = pack_owners {
        if owner != user_id {
            return models::CustomError::ForbiddenGeneric.error_response();
        }
    } else {
        return models::CustomError::NotFoundGeneric.error_response();
    }

    let mut pack = pack.into_inner();

    let res = pack_check(data, &mut pack).await;

    if res.is_err() {
        return HttpResponse::BadRequest().json(models::APIResponse {
            done: false,
            reason: Some(res.unwrap_err().to_string()),
            context: Some("Edit pack error".to_string())
        });
    }

    let res = data.database.edit_pack(pack).await;

    if res.is_err() {
        return HttpResponse::BadRequest().json(models::APIResponse {
            done: false,
            reason: Some(res.unwrap_err().to_string()),
            context: Some("Edit pack error".to_string())
        });
    }

    return HttpResponse::Ok().json(models::APIResponse {
        done: true,
        reason: Some("Edited bot pack successfully!".to_string()),
        context: None
    });
}

#[delete("/users/{user_id}/packs/{pack_id}")]
async fn delete_pack(req: HttpRequest, info: web::Path<models::GetUserPackPath>) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    let user_id = info.user_id;

    // Check auth
    let auth_default = &HeaderValue::from_str("").unwrap();
    let auth = req.headers().get("Authorization").unwrap_or(auth_default).to_str().unwrap();
    if !data.database.authorize_user(user_id, auth).await {
        error!("Pack Delete Auth error");
        return models::CustomError::ForbiddenGeneric.error_response();
    }

    // Make sure we are the owner of this pack
    let pack_owners = data.database.get_pack_owners(info.pack_id.clone()).await;

    if let Some(owner) = pack_owners {
        if owner != user_id {
            return models::CustomError::ForbiddenGeneric.error_response();
        }
    } else {
        return models::CustomError::NotFoundGeneric.error_response();
    }

    data.database.delete_pack(info.pack_id.clone()).await;

    return HttpResponse::Ok().json(models::APIResponse {
        done: true,
        reason: Some("Deleted bot pack successfully!".to_string()),
        context: None
    });
}