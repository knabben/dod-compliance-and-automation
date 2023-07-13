# TKG Compliance Overlays
**Note**: this has only been tested on aws. The ciphers used for STIG are FIPS approved(TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384) + AWS health check chiper(TLS_RSA_WITH_AES_256_GCM_SHA384). If the AWS cipher is removed it should only run with FIPS on vSphere but has not been tested. The FIPS approved ciphers do not allign with the STIG test so that control will fail.

The folder `04_user_customizations` contains scripts and ytt overlays to harden TKG for STIG. Its contents need to be placed in `$HOME/.config/tanzu/tkg/providers/ytt/04_user_customizations` 

The following env variables need to be added to your cluster configuration for tkg. 


| Env Vars| Options|
|---------|--------|
|COMPLIANCE|String: stig|
|PROTECT_KERNEL_DEFAULTS| boolean: true or false|