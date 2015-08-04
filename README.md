# Vinz Clortho

Vinz Clortho is a set of utilities that Opsee uses for key management, SSH tunneling, and general tomfoolery.

## s3kms

s3kms is a simple utility for managing encrypted files in S3 for use with
AWS's Key Management Service (KMS). It supports two operations on an object
in S3: get and put. Assuming you have the appropriate key permissions in KMS:

`s3kms put bucket/objectKey`

- Setup the appropriate encryption context in KMS
- Read from STDIN until EOF
- Encrypt the bytes read
- Put the encrypted data into the specified S3 bucket

`s3kms get bucket/objectKey`

- Setup the appropriate encryption context in KMS
- Get the encrypted data from S3
- Decrypt the read data
- Write the encrypted data to STDOUT

s3kms is configured via environment variables or via the command line. See
`s3kms help` for more information.

* `AWS_KMS_KEY_ARN`: This is the ARN to the KMS key.
* `AWS_DEFAULT_REGION`: This is the region used for everything, basically.
* `AWS_ACCESS_KEY_ID`: The access key used should have the necessary privileges in KMS.
* `AWS_SECRET_ACCESS_KEY`: Private key for associated access key id.
* `AWS_ACCOUNT_ID`: Account ID for granting read access with s3kms put.

In practice, we use a different key for environments, as opposed to entity under
encryption. This seems to be the easiest way to configure things.

## LICENSE

See [License](LICENSE.md)
