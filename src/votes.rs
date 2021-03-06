use crate::models;
use crate::converters;
use actix_web::http::header::HeaderValue;
use actix_web::{get, patch, web, http, HttpRequest, HttpResponse};
use log::error;


/// Create Bot Vote
#[patch("/users/{user_id}/bots/{bot_id}/votes")]
async fn create_bot_vote(
    req: HttpRequest,
    info: web::Path<models::GetUserBotPath>,
    vote: web::Query<models::VoteBotQuery>,
) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    let user_id = info.user_id;
    let bot_id = info.bot_id;

    // Check auth
    let auth_default = &HeaderValue::from_str("").unwrap();
    let auth = req
        .headers()
        .get("Authorization")
        .unwrap_or(auth_default)
        .to_str()
        .unwrap();
    if data.database.authorize_user(user_id, auth).await {
        let bot = data.database.get_bot(bot_id).await;
        if bot.is_none() {
            return HttpResponse::build(http::StatusCode::NOT_FOUND).json(models::APIResponse::err_small(&models::GenericError::NotFound));
        }
        let bot = bot.unwrap();
        if converters::flags_check(&bot.flags, vec![models::Flags::System as i32]) {
            return HttpResponse::build(http::StatusCode::BAD_REQUEST).json(models::APIResponse::err_small(&models::VoteBotError::System));
        }
        let vote = data.database.vote_bot(user_id, bot_id, vote.test).await;
        if vote.is_err() {
            return HttpResponse::build(http::StatusCode::BAD_REQUEST).json(models::APIResponse::err_small(&vote.unwrap_err()));
        }
        return HttpResponse::build(http::StatusCode::OK).json(models::APIResponse::ok());
    }
    error!("Vote Bot Auth error");
    HttpResponse::build(http::StatusCode::FORBIDDEN).json(models::APIResponse::err_small(&models::GenericError::Forbidden))
}

/// Create Server Vote
#[patch("/users/{user_id}/servers/{server_id}/votes")]
async fn create_server_vote(
    req: HttpRequest,
    info: web::Path<models::GetUserServerPath>,
    vote: web::Query<models::VoteBotQuery>,
) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    let user_id = info.user_id;
    let server_id = info.server_id;

    // Check auth
    let auth_default = &HeaderValue::from_str("").unwrap();
    let auth = req
        .headers()
        .get("Authorization")
        .unwrap_or(auth_default)
        .to_str()
        .unwrap();
    if data.database.authorize_user(user_id, auth).await {
        let server = data.database.get_server(server_id).await;
        if server.is_none() {
            return HttpResponse::build(http::StatusCode::NOT_FOUND).json(models::APIResponse::err_small(&models::GenericError::NotFound));
        }
        let server = server.unwrap();
        if converters::flags_check(&server.flags, vec![models::Flags::System as i32]) {
            return HttpResponse::build(http::StatusCode::BAD_REQUEST).json(models::APIResponse::err_small(&models::VoteBotError::System));
        }
        let vote = data
            .database
            .vote_server(
                &data.config.discord_http_server,
                user_id,
                server_id,
                vote.test,
            )
            .await;
        if vote.is_err() {
            return HttpResponse::build(http::StatusCode::BAD_REQUEST).json(models::APIResponse::err_small(&vote.unwrap_err()));
        }
        return HttpResponse::build(http::StatusCode::OK).json(models::APIResponse::ok());
    }
    error!("Vote Server Auth error");
    HttpResponse::build(http::StatusCode::FORBIDDEN).json(models::APIResponse::err_small(&models::GenericError::Forbidden))
}

/// Bot: Has User Voted?
#[get("/users/{user_id}/bots/{bot_id}/votes")]
async fn get_bot_votes(req: HttpRequest, info: web::Path<models::GetUserBotPath>) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();

    let user_flags = data.database.get_user_flags(info.user_id).await;

    if user_flags.contains(&models::UserFlags::VotesPrivate) {
        return HttpResponse::build(http::StatusCode::OK).json(models::UserVoted {
            vote_right_now: true,
            ..models::UserVoted::default()
        })
    }

    let resp = data.database.get_user_bot_voted(info.bot_id, info.user_id).await;
    HttpResponse::build(http::StatusCode::OK).json(resp)
}

/// Server: Has User Voted?
#[get("/users/{user_id}/servers/{server_id}/votes")]
async fn get_server_votes(req: HttpRequest, info: web::Path<models::GetUserServerPath>) -> HttpResponse {
    let data: &models::AppState = req.app_data::<web::Data<models::AppState>>().unwrap();
    
    let user_flags = data.database.get_user_flags(info.user_id).await;

    if user_flags.contains(&models::UserFlags::VotesPrivate) {
        return HttpResponse::build(http::StatusCode::OK).json(models::UserVoted {
            vote_right_now: true,
            ..models::UserVoted::default()
        })
    }
    
    let resp = data.database.get_user_server_voted(info.server_id, info.user_id).await;
    HttpResponse::build(http::StatusCode::OK).json(resp)
}