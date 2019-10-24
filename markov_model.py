import subprocess
import pandas as pd
import numpy as np


def process_data():

    df = pd.read_csv('Channel_attribution.csv')
    df = df.fillna(0)
    cols = df.columns

    for col in cols:
        df[col] = df[col].astype(int).astype(str)
        df[col] = df[col].map(lambda x : str(x)[:-2] if '.' in x else str(x))

    df['Path'] = ''
    for i in df.index:
        for x in cols:
            df.at[i, 'Path'] = df.at[i, 'Path'] + df.at[i, x] + ' '

    df['Path'] = df['Path'].map(lambda x: x.split('21')[0])
    df['Conversion'] = 1
    df['Conversion_value'] = df['Conversion'].apply(lambda x: x * abs(np.random.normal(20, 5, 1)[0]))

    df = df[['Path', 'Conversion', 'Conversion_value']]
    
    df['Path'] = df['Path'].apply(lambda x: x.replace(' ', ' > ')[:-2])

    df = df.groupby('Path').sum().reset_index()

    df.to_csv('Paths.csv', index = False)
    
    
def run_r_script():

    path2script = "Markov Chain Attribution Modeling.R"

    cmd = ['Rscript', path2script]

    subprocess.call(cmd)

    
if __name__ == "__main__":
    process_data()
    run_r_script()