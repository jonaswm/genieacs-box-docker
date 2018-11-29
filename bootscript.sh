#!/bin/bash
# Variaveis
homeDir=/opt/genieacs
binDir=/usr/local/bin
# Cria o usuário que executará o GenieACS
adduser -q --disabled-password --shell /bin/bash --home "$homeDir" --uid 3001 --gecos 'GenieACS' genieacs > /dev/null 2>&1
# Define as permissões ao usuário "genieacs" de forma que usando "sudo" ele possa executar qualquer tarefa que requer permissões administrativas (root)
echo -e "genieacs\tALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Clona os projetos: rbenv, ruby-build, genieacs e genieacs-gui
echo "" && echo "Clonando rbenv, ruby-build, genieacs e genieacs-gui..." && echo ""
git clone -q https://github.com/rbenv/rbenv.git "$homeDir"/.rbenv
git clone -q https://github.com/rbenv/ruby-build.git "$homeDir"/.rbenv/plugins/ruby-build
git clone -q https://github.com/genieacs/genieacs.git "$homeDir"/genieacs
git clone -q https://github.com/genieacs/genieacs-gui.git "$homeDir"/genieacs-gui
# Configuração para usar o gerenciador de instalação do Ruby 
echo '' >> "$homeDir"/.profile
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$homeDir"/.profile
echo 'eval "$(rbenv init -)"' >> "$homeDir"/.profile
# Configura para ao iniciar o login com o user "genieacs" o script seja executado
echo '/usr/local/bin/install.sh' >> "$homeDir"/.profile
touch "$homeDir"/.temp
# Dá as devidas permissões ao home do usuário "genieacs"
chown genieacs:genieacs -R "$homeDir"
echo "Executar o comando: su - genieacs"
echo -e "Assim que executado, a configuração estará em sua última etapa.\n"
