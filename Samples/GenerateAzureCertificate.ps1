New-PnPAzureCertificate -CommonName SitesSelectedDemo -Organization "PiaSys Tech Bites" -OutPfx .\SitesSelectedDemo.pfx -OutCert .\SitesSelectedDemo.cer -ValidYears 2 -CertificatePassword (ConvertTo-SecureString -String "***" -AsPlainText -Force)
