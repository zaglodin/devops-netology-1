# Homework 7.6

1. Все ресурсы и данные описаны здесь:  
   <https://github.com/hashicorp/terraform-provider-aws/blob/068ebd8bb5a703e92342ba69406746c993444033/aws/provider.go#L186-L1139>

   Name конфликтует с name_prefix:  
   <https://github.com/hashicorp/terraform-provider-aws/blob/068ebd8bb5a703e92342ba69406746c993444033/aws/resource_aws_sqs_queue.go#L61>

   Ограничение длины имени - 80 символов.

   Регулярное выражение - `^[a-zA-Z0-9_-]{1,80}$`
