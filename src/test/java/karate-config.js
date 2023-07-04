function(){

    var env = karate.env; // get java system property 'karate.envData' from TestRunner.java
    karate.log('karate.envData system property was:', env);

    if (!env) {
        env = 'dev'; // a custom 'intelligent' default
      }

    var config = { // base config JSON
        env,
        headers: {
            "x-reference-id": "AMS-test-1",
            "x-request-id": "AMS-req-id-1",
            "Content-Type": "application/vnd.monnai.v1.2+json",
            "Accept": "application/json"
        }
      };
    switch(env) {
        case "test":
            config.requestUrl = "https://app-us.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJkMUx1U0NPazFjQjliUFp5NVZJSEVScitqS2NoNURYU0FQM3BxN2FnampRPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJmMzRhZWE3Mi1kNjVjLTQ0ZWUtYmFhYi1kM2ZhOWJmNzQ5YTciLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV95dlZPeGo0RXkiLCJ2ZXJzaW9uIjoyLCJjbGllbnRfaWQiOiIzZjB1Y2YydTlrc3VwbGIyZnVuZzRnc284YyIsIm9yaWdpbl9qdGkiOiIzZjNiNzE4ZC0wYmEyLTQ2YjItYTQ0MC1jZDUwZWE1MTYxYmEiLCJldmVudF9pZCI6IjQwNmJiZTNhLWUyMDAtNDE0MS05ODA0LTkxNzVlOTNmZWZkMyIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoicGhvbmUgb3BlbmlkIHByb2ZpbGUgZW1haWwiLCJhdXRoX3RpbWUiOjE2ODgzNjU5NDgsImV4cCI6MTY4ODQ1MjM0OCwiaWF0IjoxNjg4MzY1OTQ5LCJqdGkiOiIyYTcwOGFhZS0wN2I1LTRlNjktYjZlMy0yZTcxZjY5ZGJkYjUiLCJ1c2VybmFtZSI6ImYzNGFlYTcyLWQ2NWMtNDRlZS1iYWFiLWQzZmE5YmY3NDlhNyJ9.csji53I59cgX6ceg91fRA8OX-IRxT3MErfGeJK6cL2RkK_ONbP5hxeSh1bP23vMBa39PoYokHyYvMoAP2okmwmlx7oORc-dAmEbYuyABmlnwiIkG5OV362B8TGJTFozs5Rd0NRdCNS2rsPDv8YxLYCrlCdswCZtNGRfgywu--caFX1_ISaUncxdPOeJqPsYiiQANFTzn9ureY4J5OWr71PXOu9IoX5HoEztF0Z0vRDqw1ncN8ML7CUAnZUnsI8EdoLZqCIvCYF_zdqaeVKW_T3BPbErTMuP1GaoQzlUvcMNXwKClUTOfbyNOjqJiyqzjSFHoe9kX7f4OMl0U0VtUyQ";
            break;
        case "release":
            config.requestUrl = "https://release.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiNjg5ZjRjZTktNWJhOC00YmJhLTk0ZDctOWZlYTM1OTZhMzVlIiwiZXZlbnRfaWQiOiJlMmQ3N2Y3MS02YjhkLTQ3MmItOTA3Ny0xOWZkYjFlZjU0ODciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjg3NzU0ODEyLCJleHAiOjE2ODc4NDEyMTIsImlhdCI6MTY4Nzc1NDgxMywianRpIjoiZjRiZDhiODUtOGRmZi00ZDJmLWJjZGEtM2E4YTFhZjg0MDEyIiwidXNlcm5hbWUiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIifQ.H5_-_X4xd-Qyg1cN6QJT9J_ZjkTpsdORB08GO6zjse5npjEfDx-c0yzoKudInjHTlna2zw99GWcElCjU03XKr-ebSUQPGrYTvLpOBgvEgvTIhkYTrgWBrpd9SivY-FxL9Ivw3uFGwtRaRdt4GyAJelu7TMJLodD_d0x2QVRT_IGDeOc1XtWcOgMnGIWkXLGKZb6Yg7sRfY2Nl2FvqXwZPM6UpX4sxk9Tx2TaZoThAtgPyCLHohqd5jPhm8qbT_Qnz3kEIRlM5ybWEO7A1bYxDe1HkE9JavRVbQTOHFgZRUhhh6uEIT5_2Mze9FRZnabIZzrSQR_8Py1jBoHhHl99TA";
            break;
        case "dev":
            config.requestUrl = "https://test.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiOTliMDEzNGUtZGJmZS00ODQ3LTkxZDItMGIxNThlODNiODQ2IiwiZXZlbnRfaWQiOiJmZTAzODZmMy1jYmNkLTQ0OTctYjA4Zi1mMzI0MTE0NGE3MWIiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjg4NDU3NTc4LCJleHAiOjE2ODg1NDM5NzgsImlhdCI6MTY4ODQ1NzU3OSwianRpIjoiN2JjNDMwNjgtMjkwMS00YjY5LTk0OWEtY2E5ODBmYzlmNzNiIiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.SQnwVHmnbwY8RAjjXGaPiJqxp0qW5RGWnFPQFXJck8P_izTKg4CdeG6_WPWZxmsrtDiMGSjpiMp3GaLqGX3LsgB96I4m18s_WLOrgIgaNGmTtxLHBIpePCvK3tHgrDQKpIVYSEmTLGCc6Hx82Xvs5M4j2tpcxc4fVFgMr9IOz2SQ-SR_DiFZaZS-TmzfVg6eO542h8g4e5qUEvlNAU9NNPec_RMPAcu9Hp7ZmvRSruLU13VYOtGsTBBdniZHK0fULR-BCOl8QRJlI-aqDPDa0ELq2JAlaLAehOcQpnyF_4VlcnYNhkGM1WDV7l_j2gdjPavx_UV1TQDuRhjZP8b-Ag";
            break;
        default:
            config.requestUrl = "https://dev.monnai.com";
            config.headers.Authorization = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiNzgxMDA5ZWYtMmIzOS00NjJhLWE0ZDctZWQ0ODkzNTI1Zjk0IiwiZXZlbnRfaWQiOiI1MTM0YzlhNy02ZTU5LTQzNjctYWNjYS1jZDdmZDNkZjY1ODciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNjgwNTEzODU5LCJleHAiOjE2ODA2MDAyNTksImlhdCI6MTY4MDUxMzg2MCwianRpIjoiMWFhODQxYWItNGEzMC00YzA3LWE0MjItNzIxM2MyYzI2ZjVkIiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.fHXQHdUh8wwHcG2fAuUhFGUdX86DNsTjifU05G6FLdnmURzgxGcLEqCIklhWcnBM78QSYErJLTk08cTDowFKASvd42RmQgocVGodSuu43-x952babebBzRI0qQs6QTVSvJw1uCKN7gFzQY2zDy4nM2oxuVeRHDY6D5t-ukWwzcymQNmY7Df-eHELz5j9KqF1yW8J9F2cbUwvATx_dUxNrrw-ZBhYzbReYf-aLc7wCVV2256vP6kvMdSGxnnYbWs78OUQ6IrhAlsOVItkyoT9I4oP6fxMnQt-NbBSezUUGzz7tHmp8rX3BgtkFHqyCX1GBde3dqzSoxgjaiv0JqDCpA";
            break;
    }

    return config;
}