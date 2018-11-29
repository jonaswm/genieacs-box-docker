# genieacs-box-docker
GenieACS in box

O projeto comtempla a criação de um ambiente em docker, utilizando dockerfile e scripts bash, com a seguinte estrutura:
- NodeJS
- Ruby
- MongoDB
- GenieACS
- GenieACS GUI

A imagem docker já está hospedada, para executar utilizando a imagem do docker hub, executar o seguinte comando:

`docker run --name genieacs --hostname genieacs -p 3000:3000 -p 7547:7547 -p 7557:7557 -p 7567:7567 -it jonaswm/genieacs-box:$BRANCH`

---

Projeto original
- https://github.com/genieacs/genieacs
- https://github.com/genieacs/genieacs-gui
