# Projeto Lógica 2019.1

O projeto consiste de duas partes. Uma especificação em **Alloy (arquivo .als)** e uma especificação em **NuSMV (arquivo .smv)** de acordo com os requisitos do tema sorteado para o grupo.

A especificação em ___Alloy___ deverá incluir a descrição estrutural do sistema e pelo menos três propriedades (fatos mais importantes). Deverá também ter pelo menos 2 asserts como casos de teste.

A especificação em ___NuSMV___ deverá incluir a descrição comportamental do sistema e pelo menos 3 propriedades descritas em LTL que o sistema deve garantir.

Cada um dos temas possui um cliente, que é o contato chave pra tirar dúvidas sobre o projeto. Vocês podem usar o slack para isso, mas tentem pelo menos um encontro presencial com o cliente.

## Sistema de Controle de Bagagens 

**Descrição:**  No aeroporto ___Flying To Heaven___, foi solicitado um novo sistema para controle de bagagens. O mesmo consiste em verificar, durante a esteira do aeroporto, se o passageiro excedeu o limite de bagagem.   
Para isso, foi necessário classificar os passageiros e as bagagens. O passageiro pode ser de três tipos:  __comum, milhagem ou VIP__; e cada mala desse passageiro também possui três classificações: __leve, mediana ou pesada__. Além disso, o passageiro terá um ticket, que pode ser __vermelho ou verde__, indicando se ele pode embarcar.  
O sistema irá considerar alguns parâmetros para verificar se o passageiro excedeu o limite:  
* Depois de verificar os pertences do passageiro, o tipo dele terá que ser considerado: Se ele for um passageiro comum, o mesmo só terá direito a no máximo uma bagagem pesada e uma leve, enquanto o passageiro milhagem tem como limite uma mala pesada, uma mediana e uma leve, entretanto, se for um VIP, terá como direito até duas pesadas, duas medianas e uma leve. 

Caso as condições não sejam satisfeitas, o passageiro não poderá embarcar e terá o ticket vermelho. Se não houver nenhum problema, o ticket terá que ser verde, significando que está apto a embarcar.

