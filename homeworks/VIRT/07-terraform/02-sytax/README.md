# Homework 7.2

1. Вывод:

    ```txt
    $ aws configure list
          Name                    Value             Type    Location
          ----                    -----             ----    --------     
       profile                <not set>             None    None
    access_key     ****************AI3O              env    
    secret_key     ****************ZD22              env    
        region               eu-north-1      config-file    ~/.aws/config
    ```

2.
   1. С помощью Packer.
   2. [Директория с файлами](terraform)

   Вывод после запуска:

    ```txt
    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

    Outputs:

    account_id = "189587461774"
    aws_region = "eu-north-1"
    caller_user = "AIDASYJCLC2HHTH23AI3O"
    private_ip = "10.0.1.10"
    subnet_id = "subnet-0b567c5c53d0329ce"
    ```
