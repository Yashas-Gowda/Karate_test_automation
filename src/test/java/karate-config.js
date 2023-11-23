function() {

   // var env = karate.env; // get java system property 'karate.envData' from TestRunner.java
    var env = 'test'
    var source = 'source'
    karate.log('karate.envData system property was:', env);

    if (!env) {
        env = 'release'; // a custom 'intelligent' default
    }

   var uuid = function(){ return java.util.UUID.randomUUID() + '' }

    var config = {
        source,
        env,
        headers: {
            "x-reference-id": uuid(),
            "x-request-id": "AMS-req-id-1",
            "Content-Type": "application/vnd.monnai.v1.2+json",
            "x-timeout":60000,
            "Accept": "application/json"

        }
    };
     switch (env) {
            case "dev-m":
                config.requestUrl = "https://dev.monnai.com";
                config.authUrl ="https://auth-dev.monnai.com";
//               config.headers.Authorization = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI2NXBtNGQ0bGZ2N2lwaW1nYzk4bHIwcTllYyIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiaW5zaWdodHNcL2JsYWNrbGlzdF9kZXRhaWxzIGluc2lnaHRzXC91cGlfYWR2YW5jZWQgaW5zaWdodHNcL2RvbWFpbl9icmVhY2ggaW5zaWdodHNcL3Bob25lX2Jhc2ljIGluc2lnaHRzXC9lbWFpbF9iYXNpYyBpbnNpZ2h0c1wvdXBpX2Jhc2ljIGluc2lnaHRzXC9lbWFpbF9zb2NpYWwgdmVyaWZpY2F0aW9uXC9reWNfbW9iaWxlIGluc2lnaHRzXC9pZGVudGl0eV9lbnJpY2htZW50X3BsdXMgaW5zaWdodHNcL2lkZW50aXR5X2NvcnJlbGF0aW9uIGluc2lnaHRzXC9pbmNvbWVfZXN0aW1hdGlvbiBpbnNpZ2h0c1wvbmFtZV9iYXNpYyBpbnNpZ2h0c1wvcGhvbmVfaWRlbnRpdHkgdmVyaWZpY2F0aW9uXC9reWNfY29uc3VtZXIgaW5zaWdodHNcL2lwX2Jhc2ljIGluc2lnaHRzXC9pZGVudGl0eV9lbnJpY2htZW50IGluc2lnaHRzXC9hZGRyZXNzX2Jhc2ljIGluc2lnaHRzXC9kZXZpY2VfZGV0YWlscyB2ZXJpZmljYXRpb25cL2t5Y19nb3Zlcm5tZW50IGluc2lnaHRzXC9lbXBsb3ltZW50X2RldGFpbHMgaW5zaWdodHNcL3Bob25lX3NvY2lhbCIsImF1dGhfdGltZSI6MTY5OTM0NTkwMSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX1NQOFc4bm5zUCIsImV4cCI6MTY5OTQzMjMwMSwiaWF0IjoxNjk5MzQ1OTAxLCJ2ZXJzaW9uIjoyLCJqdGkiOiJlNTU5NDY2OC1mNWM2LTQ2OGYtYjBhZS04Yzc2NzIwYjdmYmUiLCJjbGllbnRfaWQiOiI2NXBtNGQ0bGZ2N2lwaW1nYzk4bHIwcTllYyJ9.KYeqOiN-dW6YomZ4o3mTyfFyFsemgajz7MXY1PpjMwHwTfvA4xa-zp5boFVhnMpHEYXkWtSVCk-E_shwGqvClFrJsQxKBAH9fBlZgYU7SBIsQh-W-u9_P7oSJb5gPs3ATZOWsf-jf_7eAULLoMxPr-flKZzS_bnB1pnfdC3PXcBExVXQYtywKnVgJCJ6LIOcu7SrCDQhPjoBkakLKP8hQHLFYDWCizDWw68-dd_kXcX2TEO2pJMPW4FJpqCRRX5K_k8HN_GTxq5sSeItF9v1AU7rP6s4ERGxylo0_IT72mtoFxQwMXH_GwbYuLAc3wvbh1Hv8SwodgKy55CRgdkiEQ";
                //            config.headers.id_token = "eyJraWQiOiJCN2NiMHRuNFF2M3ZHOUxPcXV2RXhEZysxb0F3SHVZUjdDQmdIU1ZBOUZZPSIsImFsZyI6IlJTMjU2In0.eyJhdF9oYXNoIjoiOGpzMk9oNGtBcjlxbGt6bnk5NV9pZyIsInN1YiI6IjUwODI0MmU1LTZiMTYtNGY5Ni1hZTQ1LTVlMzU2ZjgwMjgxZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJyb2xlcyI6Ik1PTk5BSV9BRE1JTiIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5hcC1zb3V0aGVhc3QtMS5hbWF6b25hd3MuY29tXC9hcC1zb3V0aGVhc3QtMV9TUDhXOG5uc1AiLCJjb2duaXRvOnVzZXJuYW1lIjoiNTA4MjQyZTUtNmIxNi00Zjk2LWFlNDUtNWUzNTZmODAyODFlIiwiZ2l2ZW5fbmFtZSI6IlNhbmpheSIsIm9yaWdpbl9qdGkiOiIzMzA4YTg4Mi03YjVkLTRjYWQtYTkxOC05ZWVjMzQxNzczMzgiLCJhdWQiOiI1cDd1a25oZ2EwamZvYWhpOThsMDZpYzhhbSIsInRlbmFudE5hbWUiOiJNT05OQUkiLCJ0b2tlbl91c2UiOiJpZCIsImRvbWFpbiI6Im1vbm5haS5jb20iLCJhdXRoX3RpbWUiOjE2OTkyNjcyMzEsInRlbmFudElkIjoidGVuYW50XzAxR0tLWjhITUgyRlFIQkhFMDhZSE1ISktaIiwiZXhwIjoxNjk5MzUzNjMxLCJpYXQiOjE2OTkyNjcyMzIsImZhbWlseV9uYW1lIjoiR293ZGFyIFMiLCJqdGkiOiIwZjgwMjQ2MS01NzU0LTQyZTYtYWYwNy01MjhkYWIxMmM2MzEiLCJlbWFpbCI6InNhbmpheWFAbW9ubmFpLmNvbSJ9.pSnZgw666MyDhkG2GKG-Odx6_isK8gsOOrodgtpIFHR9TDtZ0_h-AkhLyMekZzqIdke5uCbq5y_1wySHjKtvnBldnQ5Jj1a0aLhBzYnZYEFUAmaWnBu5KyJMIfVSIHOL6b9R3o2_uN7-4-RSSNzUGcXSL1zRZwSdzju7JanrHND5DuNzz3WqBNWe0XznKrTlTSqVhuotEXg2lkTrbf7-KN57cso5IjXdJdAh6dkxvlnVqO1iSkXiifmxvsCKyICEbjWazVaLiYPrhmqsjizNLWG2QFucqrxNNFpcDQHTt1ZMJYP9NPZay6155CJ7rVY0nQVZ8r1bToOaNSiJddkJXQ";
                break;

            case "release":
                 config.requestUrl = "https://release.monnai.com";
                 config.authUrl ="https://release-auth.monnai.com";
                 break;
            case "release-m":
                  config.requestUrl = "https://release.monnai.com";
                  config.authUrl ="https://release-auth.monnai.com";
                  break;

            case "test":
                config.requestUrl = "https://test.monnai.com";
                config.authUrl ="https://test-auth.monnai.com";
                break;
            case "test-m":
                config.requestUrl = "https://test.monnai.com";
                config.authUrl ="https://test-auth.monnai.com";
                break;

            case "app":
                config.requestUrl = "https://app.monnai.com";
                config.authUrl ="https://auth.monnai.com";
                break;
            case "app-sg":
                config.requestUrl = "https://app-sg.monnai.com";
                config.authUrl ="https://auth-sg.monnai.com";
                break;
            case "app-id":
                config.requestUrl = "https://app-id.monnai.com";
                config.authUrl ="https://auth-sg.monnai.com";
                break;
            case "app-us":
                config.requestUrl = "https://app-us.monnai.com";
                config.authUrl ="https://auth-us.monnai.com";
                break;

            default:
                config.requestUrl = "https://test.monnai.com";
                config.headers.Authorization = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiYmI3YzVjNTktNTA1OS00NGJlLTlhOTEtYWE0NmNiNzIxNGExIiwiZXZlbnRfaWQiOiJjOWU1MDJlZS1hMGE4LTQyZTQtYTk4Ni0xMDM5NWNkN2Y5YzgiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjk1ODQyMjE2LCJleHAiOjE2OTU5Mjg2MTYsImlhdCI6MTY5NTg0MjIxNywianRpIjoiYmJmYzRlNzEtMmUzYS00ODA0LWJkMzYtOTVjMDM4ODE5MmQxIiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.nS7rUPm98CAyWzOR_w2z-pcn3JP3kLMwNIdL5cJewzjtsamB4obpCFG6KQ2WZU7A58veonBcuPcotwNEYxvO0HQu-HCugsBzrtCpaJiqnxjaAnsQ0B_TdwQFq0mXkQKVfj-eLivc1AZt5XTJ6ey0ZNeylPEwSrq9OKJF6Gu9Nwg_YQo96Bq5pn03PGF0SmX5OLYr_qqn9HPGlv1kkQUdpnxu4W_Ajms7O0V6VLNpEiXF5_AjvffCC-k7wR-oFcdp9JGKD3vk9EX6BxEahbd4DeCf1wCrUTL4d9WLFZnrmkno-OxF9qqjLwd2eI1y_rEWWNTquUkACGgoGUKBEEjTHA";
                break;
        }
//      karate.configure('connectTimeout', 5000);
//      karate.configure('readTimeout', 5000);
    return config;

}
