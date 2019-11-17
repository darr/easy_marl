#!/bin/bash
#####################################
## File name : run.sh
## Create date : 2018-11-26 11:19
## Modified date : 2019-11-17 23:40
## Author : DARREN
## Describe : not set
## Email : lzygzh@126.com
####################################

realpath=$(readlink -f "$0")
basedir=$(dirname "$realpath")
export basedir=$basedir/cmd_sh/
export filename=$(basename "$realpath")
export PATH=$PATH:$basedir
export PATH=$PATH:$basedir/dlbase
export PATH=$PATH:$basedir/dlproc
#base sh file
. dlbase.sh
#function sh file
. etc.sh

. install_multiagent_particle_envs.sh
. install_maddpg.sh

kill -9 `ps -ef|grep main.py|grep -v grep|awk '{print $2}'`
kill -9 `ps -ef|grep defunct|grep -v grep|awk '{print$3}'`

function create_vir_env(){
    dlfile_check_is_have_dir $env_path

    if [[ $? -eq 0 ]]; then
        bash ./cmd_sh/create_env.sh
    else
        $DLLOG_INFO "$1 virtual env had been created"
    fi
}

create_vir_env

#bash ./cmd_sh/check_code.sh

#   source $env_path/py2env/bin/activate
#   deactivate

source $env_path/py3env/bin/activate
# install openai multiagent-particle-envs
cd ../multiagent-particle-envs
pip install -e .
# install openai maddpg
cd ../maddpg
pip install -e .
cd ../easy_marl

#   python interactive.py --scenario simple.py
#   python interactive.py --scenario simple_adversary.py
#   python interactive.py --scenario simple_crypto.py
#   python interactive.py --scenario simple_push.py
#   python interactive.py --scenario simple_reference.py
#   python interactive.py --scenario simple_speaker_listener.py
#   python interactive.py --scenario simple_spread.py
#   python interactive.py --scenario simple_tag.py
#   python interactive.py --scenario simple_world_comm.py

#python train.py --scenario simple --exp-name hello 
python train.py --scenario simple_adversary --exp-name hello2 
#python train.py --scenario simple_crypto --exp-name hello3
#python train.py --scenario simple_push --exp-name hello4
#python train.py --scenario simple_reference --exp-name hello5 

deactivate
