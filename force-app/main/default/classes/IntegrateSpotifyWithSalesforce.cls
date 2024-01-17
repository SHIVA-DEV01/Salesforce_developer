public with sharing class IntegrateSpotifyWithSalesforce {
    // Spotify API endpoint URLs
    private static final String SPOTIFY_AUTH_URL = 'https://accounts.spotify.com/api/token';
    private static final String SPOTIFY_TOP_TRACKS_URL = 'https://api.spotify.com/v1/recommendations';

    // Spotify Application credentials
    private static final String SPOTIFY_CLIENT_ID = 'a72e28aa9d8746e48d7e4057169b74c0';
    private static final String SPOTIFY_CLIENT_SECRET = '256af362729149b49a3f6203727061a0';

    // Method to retrieve access token from Spotify
    @AuraEnabled(cacheable=true)
    public static String getSpotifyAccessToken() {
        HttpRequest request = new HttpRequest();
        // String URL = SPOTIFY_AUTH_URL + '?client_id='+SPOTIFY_CLIENT_ID+'&client_secret='+SPOTIFY_CLIENT_SECRET;
        request.setEndpoint(SPOTIFY_AUTH_URL);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('grant_type=client_credentials&client_id='+SPOTIFY_CLIENT_ID+'&client_secret='+SPOTIFY_CLIENT_SECRET);

        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> spotifyResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return (String) spotifyResponse.get('access_token');
        }
        return null;
    }

    // Method to retrieve user's top tracks from Spotify
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getTopTracks() {
        String spotifyAccessToken = getSpotifyAccessToken();
        if (spotifyAccessToken != null) {
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.spotify.com/v1/recommendations?limit=1&seed_tracks=5PX54UGyH80kDwLP5duZoT');
            request.setMethod('GET');
            // request.setBody('limit=5&seed_tracks=5PX54UGyH80kDwLP5duZoT');
            request.setHeader('Authorization', 'Bearer ' + spotifyAccessToken);

            HttpResponse response = new Http().send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> spotifyResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug(spotifyResponse);
                return (Map<String, Object>) spotifyResponse;
            }
            System.debug(response.getStatusCode());
        }
        return new Map<String, Object>();
    }
}