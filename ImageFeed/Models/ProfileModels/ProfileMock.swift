//
//  ProfileMock.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 08.10.2024.
//

import Foundation

struct ProfileMock {
    // MARK: - Public Properties
    let json = """
    {
        "id": "O09JInJLDxI",
        "updated_at": "2024-10-08T12:09:49Z",
        "username": "fantast2912",
        "name": "Maks Zakharov",
        "first_name": "Maks",
        "last_name": "Zakharov",
        "twitter_username": null,
        "portfolio_url": null,
        "bio": null,
        "location": null,
        "links": {
            "self": "https://api.unsplash.com/users/fantast2912",
            "html": "https://unsplash.com/@fantast2912",
            "photos": "https://api.unsplash.com/users/fantast2912/photos",
            "likes": "https://api.unsplash.com/users/fantast2912/likes",
            "portfolio": "https://api.unsplash.com/users/fantast2912/portfolio",
            "following": "https://api.unsplash.com/users/fantast2912/following",
            "followers": "https://api.unsplash.com/users/fantast2912/followers"
        },
        "profile_image": {
            "small": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
            "medium": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
            "large": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
        },
        "instagram_username": null,
        "total_collections": 0,
        "total_likes": 0,
        "total_photos": 0,
        "total_promoted_photos": 0,
        "total_illustrations": 0,
        "total_promoted_illustrations": 0,
        "accepted_tos": false,
        "for_hire": false,
        "social": {
            "instagram_username": null,
            "portfolio_url": null,
            "twitter_username": null,
            "paypal_email": null
        },
        "followed_by_user": false,
        "photos": [],
        "badge": null,
        "tags": {
            "custom": [],
            "aggregated": []
        },
        "followers_count": 0,
        "following_count": 0,
        "allow_messages": true,
        "numeric_id": 17311974,
        "downloads": 0,
        "meta": {
            "index": false
        },
        "uid": "O09JInJLDxI",
        "confirmed": true,
        "uploads_remaining": 10,
        "unlimited_uploads": false,
        "email": "z_maks@inbox.ru",
        "dmca_verification": "unverified",
        "unread_in_app_notifications": false,
        "unread_highlight_notifications": false
    }
    """
}
