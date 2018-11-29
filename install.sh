#!/bin/bash
if [ -e ~/.temp ]; then
    rm -rf ~/.temp

    # Instalação do Ruby, dunble e rails
    echo -e "\nInstalando Ruby, bundle e rails..."
    rbenv install 2.5.3 > /dev/null 2>&1
    rbenv global 2.5.3 > /dev/null 2>&1
    echo "gem: --no-document" > ~/.gemrc
    gem install bundler > /dev/null 2>&1
    gem install rails > /dev/null 2>&1

    # Inicialização do MongoDB
    echo -e "\nIniciando MongoDB..."
    sudo -S -u mongodb mongod -f /etc/mongod.conf &

    # Instalação do GenieACS e inicialização dos serviços
    echo -e "\nInstalando GenieACS e iniciando os serviços..."
    cd ~/genieacs/
    npm -s install > /dev/null 2>&1
    npm -s run configure > /dev/null 2>&1
    sudo /opt/genieacs/genieacs/bin/genieacs-cwmp > /dev/null 2>&1 &
    sudo /opt/genieacs/genieacs/bin/genieacs-nbi > /dev/null 2>&1 &
    sudo /opt/genieacs/genieacs/bin/genieacs-fs > /dev/null 2>&1 &

    # Instalação da interface gráfica do GenieACS
    echo -e "\nInstalando GenieACS GUI..."
    cd ~/genieacs-gui/
    cp -p config/graphs-sample.json.erb config/graphs.json.erb
    cp -p config/index_parameters-sample.yml config/index_parameters.yml
    cp -p config/parameter_renderers-sample.yml config/parameter_renderers.yml
    cp -p config/parameters_edit-sample.yml config/parameters_edit.yml
    cp -p config/roles-sample.yml config/roles.yml
    cp -p config/summary_parameters-sample.yml config/summary_parameters.yml
    cp -p config/users-sample.yml config/users.yml
    bundle install > /dev/null 2>&1
    # Iniciando o projeto o GUI em Rails
    echo -e "\nIniciando interface Web na porta 3000..."
    rails server -b 0.0.0.0 -d > /dev/null 2>&1

    cd ~
    echo -e "\n>>> Configuração concluída!\n"
    ip=`sudo ifconfig eth0 | grep inet | awk '{print $2}' | cut -d ':' -f2`
    echo "Projeto acessível via browser pelo endereço:"
    echo "http://$ip:3000/"
    echo -e "Credeciais:\nUsuário: admin\nSenha: admin\n"
else
    exit
fi
