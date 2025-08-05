# [CLI Configuration](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html)
- Configuration file path is at `~/.aws/config/`
- Configuration file uses INI format


## Profile section `[profile <profile_name>]` || `[default]`
- Grouping of configurations specifying how the CLI should behave for a specific context or environment. 
- Used by specifying the `--profile <profile_name>` or through the `AWS_PROFILE` environment variable.
- Nothing required here, can be left empty and the CLI will fallback to environment variables, IAM roles, or other credential sources. 
- Generally could look something like:
```
[default]
sso_session = <session_name>
sso_account_id = <account_id>
sso_role_name = <role>
region = <region>
output = <output>
```


## SSO session section `[sso-session <session_name>]`
- Grouping of configuration variables for acquiring SSO tokens which is used to acquire AWS credentials.
    - (Required) `sso_start_url`
    - (Required) `sso_region`
    - `sso_account_id`
    - `sso_role_name`
    - `sso_registration_scopes`
- Associated to a profile.

## Services section `[services <service_name>]`
- Grouping of settings configuring custom endpoints for an AWS service request.

