use serde::Serialize;
use crate::models;
use bevy_reflect::{Reflect, Struct};

fn _get_value_from(
    value: &dyn Reflect,
) -> String {
    let mut field_name_ext: String = value.type_name().to_string();    

    // type_name replacer
    field_name_ext = field_name_ext.replace("core::option::Option", "Optional ");
    field_name_ext = field_name_ext.replace("alloc::string::", "");

    // Optional string case
    if let Some(value) = value.downcast_ref::<Option<String>>() {
        match value {
            Some(value) => {
                field_name_ext = "String? ".to_string() + "| default = " + value;
            },
            None => {
                // Ignored
            },
        }
    }

    // Optional i64 case
    if let Some(value) = value.downcast_ref::<Option<i64>>() {
        match value {
            Some(value) => {
                field_name_ext = "i64? ".to_string() + "| default = " + &value.to_string();
            },
            None => {
                // Ignored
            },
        }
    }    

    "[".to_owned() + &field_name_ext + " (type info may be incomplete, see example)]"
}

fn _get_params<T: Struct>(
    params: &T,
) -> String {
    let mut params_string = String::new();
    for (i, value) in params.iter_fields().enumerate() {
        let field_name: String = params.name_at(i).unwrap().to_string();
        let field_value = _get_value_from(value);
        params_string += &format!(
            "- **{field_name}** {field_value}\n",
            field_name = field_name,
            field_value = field_value,
        )
    }
    params_string
}

fn doc<T: Serialize, T2: Serialize, T3: Struct + Serialize, T4: Struct + Serialize>(
    route: models::Route<T, T2, T3, T4>,
) -> String {
    // Serialize request body
    let buf = Vec::new();
    let formatter = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser = serde_json::Serializer::with_formatter(buf, formatter);
    
    route.request_body.serialize(&mut ser).unwrap();

    // Serialize response body
    let buf2 = Vec::new();
    let formatter2 = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser2 = serde_json::Serializer::with_formatter(buf2, formatter2);

    route.response_body.serialize(&mut ser2).unwrap();

    // Serialize query parameters
    let buf4 = Vec::new();
    let formatter4 = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser4 = serde_json::Serializer::with_formatter(buf4, formatter4);

    let mut query_params_str = _get_params(route.query_params);

    route.query_params.serialize(&mut ser4).unwrap();

    let query_params_json = &String::from_utf8(ser4.into_inner()).unwrap();

    query_params_str += &("\n\n**Example**\n\n```json\n".to_string() + &query_params_json.clone() + "\n```");

    // Serialize path parameters
    let buf3 = Vec::new();
    let formatter3 = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser3 = serde_json::Serializer::with_formatter(buf3, formatter3);

    let mut path_params_str = _get_params(route.path_params);

    route.path_params.serialize(&mut ser3).unwrap();

    let path_params_json = &String::from_utf8(ser3.into_inner()).unwrap();

    path_params_str += &("\n\n**Example**\n\n```json\n".to_string() + &path_params_json.clone() + "\n```");

    let mut base_doc = format!(
        "## {title}\n### {method} {path}\n\n{description}\n\n**API v2 analogue:** {equiv_v2_route}",
        title = route.title,
        method = route.method,
        path = route.path,
        description = route.description,
        equiv_v2_route = route.equiv_v2_route,
    );

    if path_params_json.len() > 2 {
        base_doc += &("\n\n**Path parameters**\n\n".to_string() + &path_params_str);
    }
    if query_params_json.len() > 2 {
        base_doc += &("\n\n**Query parameters**\n\n".to_string() + &query_params_str);
    }

    return base_doc + &format!(
        "\n\n**Request Body**\n\n```json\n{request_body}\n```\n\n**Response Body**\n\n```json\n{response_body}\n```\n\n\n",
        request_body = String::from_utf8(ser.into_inner()).unwrap(),
        response_body = String::from_utf8(ser2.into_inner()).unwrap(),
    );
}

pub fn document_routes() -> String {
    let mut docs: String = "# API v3\n**API URL**: ``https://next.fateslist.xyz`` (for now, can change in future)\n".to_string();

    // Add basic auth stuff
    docs += r#"
## Authorization

- **Bot:** These endpoints require a bot token. 
You can get this from Bot Settings. Make sure to keep this safe and in 
a .gitignore/.env. A prefix of `Bot` before the bot token such as 
`Bot abcdef` is supported and can be used to avoid ambiguity but is not 
required. The default auth scheme if no prefix is given depends on the
endpoint: Endpoints which have only one auth scheme will use that auth 
scheme while endpoints with multiple will always use `Bot` for 
backward compatibility

- **Server:** These endpoints require a server
token which you can get using ``/get API Token`` in your server. 
Same warnings and information from the other authentication types 
apply here. A prefix of ``Server`` before the server token is 
supported and can be used to avoid ambiguity but is not required.

- **User:** These endpoints require a user token. You can get this 
from your profile under the User Token section. If you are using this 
for voting, make sure to allow users to opt out! A prefix of `User` 
before the user token such as `User abcdef` is supported and can be 
used to avoid ambiguity but is not required outside of endpoints that 
have both a user and a bot authentication option such as Get Votes. 
In such endpoints, the default will always be a bot auth unless 
you prefix the token with `User`
"#;

    // API Response route
    let buf = Vec::new();
    let formatter = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser = serde_json::Serializer::with_formatter(buf, formatter);
    
    models::APIResponse {
        done: true,
        reason: Some("Reason for success of failure, can be null".to_string()),
        context: Some("Any extra context".to_string()),
    }.serialize(&mut ser).unwrap();

    docs += &("\n## Base Response\n\nA default API Response will be of the below format:\n\n```json\n".to_string() + &String::from_utf8(ser.into_inner()).unwrap() + "\n```\n\n");

    // TODO: For each route, add doc system


    // - Index route
    let index_bots = vec![models::IndexBot::default()];

    let tags = vec![models::Tag::default()];

    let features = vec![models::Feature::default()];

    docs += &doc(models::Route {
        title: "Index",
        method: "GET",
        path: "/index",
        path_params: &models::Empty {},
        query_params: &models::IndexQuery {
            target_type: Some("bot".to_string()),
        },
        description: "Returns the index for bots and servers",
        request_body: &models::Empty {},
        response_body: &models::Index {
            top_voted: index_bots.clone(),
            certified: index_bots.clone(),
            new: index_bots, // Clone later if needed
            tags,
            features,
        },
        equiv_v2_route: "(no longer working) [Get Index](https://api.fateslist.xyz/docs/redoc#operation/get_index)",
    });


    // - Vanity route
    docs += &doc( models::Route {
        title: "Resolve Vanity",
        method: "GET",
        path: "/code/{code}",
        path_params: &models::VanityPath {
            code: "my-vanity".to_string(),
        },
        query_params: &models::Empty {},
        description: "Resolves the vanity for a bot/server in the list",
        request_body: &models::Empty {},
        response_body: &models::Vanity {
            target_id: "0000000000".to_string(),
            target_type: "bot | server".to_string(),
        },
        equiv_v2_route: "(no longer working) [Get Vanity](https://api.fateslist.xyz/docs/redoc#operation/get_vanity)",
    });

    // - Fetch Bot route
    docs += &doc( models::Route {
        title: "Get Bot",
        method: "GET",
        path: "/bots/{id}",
        path_params: &models::FetchBotPath::default(),
        query_params: &models::FetchBotQuery::default(),
description: r#"
Fetches bot information given a bot ID. If not found, 404 will be returned. 

This endpoint handles both bot IDs and client IDs

Differences from API v2:

- Unlike API v2, this does not support compact or no_cache. Owner order is also guaranteed
- *``long_description/css`` is sanitized with ammonia by default, use `long_description_raw` if you want the unsanitized version*
- All responses are cached for a short period of time. There is *no* way to opt out unlike API v2
- Some fields have been renamed or removed (such as ``promos`` which may be readded at a later date)

**Set the Frostpaw header if you are a custom client**
"#,
    request_body: &models::Empty{},
    response_body: &models::Bot::default(), // TODO
    equiv_v2_route: "[Fetch Bot](https://api.fateslist.xyz/docs/redoc#operation/fetch_bot)",
    });

    // - Search List route
    docs += &doc(models::Route {
        title: "Search List",
        method: "GET",
        path: "/search?q={query}",
        path_params: &models::Empty {},
        query_params: &models::SearchQuery {
            q: Some("mew".to_string()),
        },
        description: r#"Searches the list based on a query named ``q``"#,
        request_body: &models::Empty {},
        response_body: &models::Search {
            bots: vec![models::IndexBot::default()],
            servers: vec![models::IndexBot::default()],
            packs: vec![models::BotPack::default()],
            profiles: vec![models::SearchProfile::default()],
            tags: models::SearchTags {
                bots: vec![models::Tag::default()],
                servers: vec![models::Tag::default()]
            },
        },
        equiv_v2_route: "(no longer working) [Fetch Bot](https://api.fateslist.xyz/docs/redoc#operation/search_list)",
    });

    docs += &doc(
        models::Route {
            title: "Random Bot",
            method: "GET",
            path: "/random-bot",
            path_params: &models::Empty {},
            query_params: &models::Empty {},
            request_body: &models::Empty {},
            response_body: &models::IndexBot::default(),
description: r#"
Fetches a random bot on the list

Example:
```py
import requests

def random_bot():
    res = requests.get(api_url"/random-bot")
    json = res.json()
    if res.status != 200:
        # Handle an error in the api
        ...
    return json
```
"#,
            equiv_v2_route: "(no longer working) [Fetch Random Bot](https://api.fateslist.xyz/api/docs/redoc#operation/fetch_random_bot)",
    });

    // Return docs
    docs
}