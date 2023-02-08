import pandas as pd
import numpy as np
#
df = pd.read_csv("yeastobservation_wProtNorm.csv")

allLines = ""

for li, row in df.iterrows():
    i = 0
    mean = 0
    count = 0
    for col in list(df.columns)[3:]:
        if not np.isnan(row[col]):
            mean+=row[col]
            count+=1

        if i%2==1:
            if count==2:
                mean/=2

            if count>0:

                if mean <= -0.5:
                    change = "down"
                elif mean >= 0.5:
                    change = "up"
                else:
                    change = "unaffected"

                allLines += f"perturbs('{col.split('_')[0][1:].upper()}', '{row['Gene Symbol pSTY position']}', '{row['Gene Symbol pSTY position'].split('_')[0]}', {change}, {mean}).\n"
        else:
            mean = 0
            count = 0

        i+=1

    print(f"{li}/{df.shape[0]}")

with open("yeastobservations2.pl", "w") as f:
    f.write(allLines)

#perturbs('Vemurafenib', 'SH3BP1(S550)', 'SH3BP1', unaffected, 0.41815910143970225, 0.35675596465567583).





import csv

with open('yeast_observation_paper_norm.csv', 'r') as input_file, open('yeastobservations4.pl', 'w') as output_file:
    # Create a CSV reader
    reader = csv.reader(input_file)

    # Read the header row
    header = next(reader)

    # Iterate over the rows in the input file
    for row in reader:
        # Get the values from the row
        gene_symbol, gene_symbol_psty_position, log2ratio = row

        # Parse the values from the strings
        gene_symbol = gene_symbol[1:]
        gene_symbol = gene_symbol.upper()# Remove the leading delta character
        gene, psty_position = gene_symbol_psty_position.split('_')
        log2ratio = float(log2ratio)

        # Determine the direction of the perturbation
        if log2ratio > 0:
            direction = 'up'
        else:
            direction = 'down'

        # Write the perturbs line to the output file
        output_file.write("perturbs('{}', '{}', '{}', {}, {}).\n".format(gene_symbol, gene_symbol_psty_position, gene, direction, log2ratio))
