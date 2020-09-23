#!/bin/sh

# Author : Ashish R. Tiwari

# User will provide project name.
echo "Enter the Project Name:"
read PROJECT_NAME

echo "Enter the Project Type No. : 0.Normal Virtual Enviorment.\n 1. Machine Learning.\n 2. Deep Learning.\n 3.Natural. Language Processing.\n"
read PROJECT_TYPE

virtualenv $PROJECT_NAME

echo "Enter the Project Owner : "
read PROJECT_OWNER

echo "Enter the Owner Group Name : "
read GROUP_NAME

sudo chown $PROJECT_OWNER:$GROUP_NAME ./$PROJECT_NAME/*
sudo chmod -R 755 ./$PROJECT_NAME/*

source ./$PROJECT_NAME/bin/activate

touch ./$PROJECT_NAME/requirements.txt

if [ $PROJECT_TYPE == 1 ]
then
    echo  "numpy\npandas\nmatplotlib\nseaborn\nsklearn\njupyter\nscipy\nstatsmodels\nrequests\nbeautifulsoup4" > ./$PROJECT_NAME/requirements.txt
elif [ $PROJECT_TYPE == 2 ]
then
    echo  "numpy\npandas\nmatplotlib\nseaborn\nsklearn\njupyter\nscipy\nstatsmodels" > ./$PROJECT_NAME/requirements.txt
elif [ $PROJECT_TYPE == 3 ]
then
    echo  "numpy\npandas\nmatplotlib\nseaborn\nsklearn\njupyter\nscipy\nrequests\nbeautifulsoup4\nstatsmodels\nnltk\nspacy\ntextblob\nvocabulary\npattern\npolyglot" > ./$PROJECT_NAME/requirements.txt
elif [ $PROJECT_TYPE == 0 ]
then
    echo "" > ./$PROJECT_NAME/requirements.txt
else
    echo "Project is not created."
fi

 mkdir ./$PROJECT_NAME/src

for FILE in create_folds.py train.py inference.py models.py config.py model_dispatcher.py
do
    touch ./$PROJECT_NAME/src/$FILE
    if [ "train.py" == "$FILE" ]
    then
        echo  "import warnings\nwarnings.filterwarnings(\"ignore\")\nimport os\nimport numpy as np\nimport pandas as pd\nimport joblib\nimport config\nimport model_dispatcher" > ./$PROJECT_NAME/src/$FILE
    fi
done

for FOLDER_NAME in input models notebooks
do
    mkdir -p ./$PROJECT_NAME/src/$FOLDER_NAME
done

./$PROJECT_NAME/bin/activate

./$PROJECT_NAME/bin/python -m pip install --upgrade pip

./$PROJECT_NAME/bin/python -m pip install -r ./$PROJECT_NAME/requirements.txt

./$PROJECT_NAME/bin/python -m pip freeze > ./$PROJECT_NAME/requirements.txt