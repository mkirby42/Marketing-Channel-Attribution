import pandas as pd

def process_data():

    df = pd.read_csv('Channel_attribution.csv')
    df = df.fillna(0)

    cols = df.columns

    for col in cols:
        df[col] = df[col].astype(str)
        df[col] = df[col].map(lambda x : str(x)[:-2] if '.' in x else str(x))
        df[col] = df[col].map(lambda x : x.replace('0', ''))

    df['Path'] = ''
    for i in df.index:
        for x in cols:
            df.at[i, 'Path'] = df.at[i, 'Path'] + df.at[i, x] + ' '

    df['Path'] = df['Path'].map(lambda x: x.split('21')[0])

    df['Conversion'] = 1

    df = df[['Path', 'Conversion']]
    
    df['Path'] = df['Path'].apply(lambda x: x.replace(' ', ' >')[:-1])

    df = df.groupby('Path').sum().reset_index()

    df.to_csv('Paths.csv', index = False)



if __name__ == "__main__":
    process_data()