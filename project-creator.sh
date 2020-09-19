#!/bin/sh

# Author : Ashish R. Tiwari

# User will provide project name.

sudo python -m pip install --upgrade pip

sudo pip install virtualenv 

echo "Enter the Project Name:"
read PROJECT_NAME

virtualenv $PROJECT_NAME
cd $PROJECT_NAME

for FOLDER_NAME in input src models notebooks
do
    mkdir -p ./$FOLDER_NAME
    if [ "src" == "$FOLDER_NAME" ]
    then   
        for FILE in create_folds.py train.py inference.py models.py config.py model_dispatcher.py
        do
            touch ./$FOLDER_NAME/$FILE
            if [ "train.py" == "$FILE" ]
            then
                echo "import warnings\nwarnings.filterwarnings(\"ignore\")\nimport os\nimport numpy as np\nimport pandas as pd\nimport joblib\nimport config\nimport model_dispatcher" > ./$FOLDER_NAME/$FILE
            fi
        done
    fi
done