# Get an authenticated client 

There are (at least) two options for creating an authenticated client for use with [googleapis](https://github.com/dart-lang/googleapis). 

Option 1: 
- make a new GCP service account 
- give the service account an appropriate Role (eg. GCS Admin) 
- download the service account credentials 
- create an authenticated client with (something like) "clientFromServiceAccountJson" 

Option 2: 
- give the default service account the appropriate Role (eg. GCS Admin) 
- create an authenticated client with (something like) "clientFromADC" 
