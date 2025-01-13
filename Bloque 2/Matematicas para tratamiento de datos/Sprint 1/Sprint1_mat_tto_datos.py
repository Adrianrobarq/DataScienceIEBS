'''
Sprint 1 - Matemáticas para el tratamiento de datos

Autor: Adrián Robles Arques

Objetivo: Aplicar matrices a un caso real
'''
import numpy as np
import pandas as pd

#Introducimos los datos
Rafa = [6,5,3,1]
Pedro = [3,6,2,2]
Maria = [3,4,3,1]

ManoloBakes = [1.5, 2.0, 5.0, 16.0]
Starbucks = [1.0, 2.5, 4.5, 17.0]

#Creamos las matrices
Compra = np.array([Rafa, Pedro, Maria]).transpose()

Precios = np.array([ManoloBakes, Starbucks], dtype= 'f')

#Multiplicamos matrices
Gasto = np.dot(Precios, Compra).transpose()

Gasto_Rafa = Gasto[0]
Gasto_Pedro = Gasto[1]
Gasto_Maria = Gasto[2]

#Alternativa usando diccionarios
Compradores = {'Rafa' : [6,5,3,1], 'Pedro' : [3,6,2,2], 'Maria' : [3,4,3,1]}
Tiendas = { 'Starbucks' : [1.0, 2.5, 4.5, 17.0], 
           'ManoloBakes' : [1.5, 2.0, 5.0, 16.0] }

Gasto = {}
for comprador in Compradores:
    for tienda in Tiendas:
        Gasto[comprador+tienda] = np.dot(Compradores[comprador],Tiendas[tienda])
        
#Alternativa con Dataframes
productos = ['Palmeras','Donuts', 'Hojaldres', 'Tartas']
personas = ['Rafa', 'Pedro', 'Maria']
tiendas = ['Starbucks', 'ManoloBakes']

df_compradores = pd.DataFrame(Compradores, dtype= np.float32,
                              index= productos)
df_tiendas = pd.DataFrame(Tiendas, dtype= np.float32,
                          index= productos)

gasto = []
for persona in personas:
    comprador = []
    for tienda in tiendas:
        coste = 0
        for producto in productos:
            coste += df_compradores[persona][producto] * df_tiendas[tienda][producto]
        comprador.append(coste)
    gasto.append(comprador)

df_gasto = pd.DataFrame(gasto, index= personas, columns= tiendas)

