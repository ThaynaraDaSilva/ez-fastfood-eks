# ez-fastfood-eks

Este repositório é dedicado à configuração dos **recursos do AWS EKS** do projeto **ez-fastfood** .


### Pré-requisitos (execução via pipeline)
1. **Terraform**
2. **Credenciais AWS**: Configure as credenciais AWS para permitir o provisionamento de recursos.  

No pipeline configurado no GitHub Actions, as credenciais foram armazenadas como **secret variables** para evitar exposição direta no código:  
  - **AWS_ACCESS_KEY_ID**  
  - **AWS_SECRET_ACCESS_KEY**

## Links dos demais repositórios:
- Network: https://github.com/ThaynaraDaSilva/ez-fastfood-network
- RDS: https://github.com/ThaynaraDaSilva/ez-fastfood-database
- Lambda: https://github.com/ThaynaraDaSilva/ez-fastfood-authentication
- APIs: https://github.com/ThaynaraDaSilva/ez-fastfood-api
- Apresentação da arquitetura: https://www.youtube.com/watch?v=MhPpoUZhlFs

## Desenvolvido por:
@tchfer : RM357414<br>
@ThaynaraDaSilva : RM357418<br>
