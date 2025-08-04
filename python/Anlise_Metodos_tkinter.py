
import tkinter as tk
from tkinter import messagebox

# Função que analisa o texto digitado pelo usuário
def analisar_texto():
    texto = entrada.get()  # Pega o texto da caixa de entrada

    # Realiza as análises com base nos métodos de string
    tipo = type(texto)
    so_espacos = texto.isspace()
    numerico = texto.isnumeric()
    alfabetico = texto.isalpha()
    alfanumerico = texto.isalnum()
    maiusculas = texto.isupper()
    minusculas = texto.islower()
    capitalizado = texto.istitle()

    # Contagens manuais usando list comprehensions
    qtd_maiusculas = sum(1 for c in texto if c.isupper())
    qtd_minusculas = sum(1 for c in texto if c.islower())
    qtd_letras = sum(1 for c in texto if c.isalpha())
    qtd_numeros = sum(1 for c in texto if c.isdigit())
    qtd_total = len(texto)

    # Verifica se há ao menos uma letra maiúscula
    tem_maiuscula = any(c.isupper() for c in texto)

    # Prepara a mensagem de saída
    resultado = (
        f"Texto analisado: {texto}\n\n"
        f"Tipo primitivo: {tipo}\n"
        f"Só tem espaços? {so_espacos}\n"
        f"É numérico? {numerico}\n"
        f"É alfabético? {alfabetico}\n"
        f"É alfanumérico? {alfanumerico}\n"
        f"Está em maiúsculas? {maiusculas}\n"
        f"Está em minúsculas? {minusculas}\n"
        f"Está capitalizado? {capitalizado}\n"
        f"Tem ao menos uma letra maiúscula? {tem_maiuscula}\n\n"
        f"Quantidade de letras maiúsculas: {qtd_maiusculas}\n"
        f"Quantidade de letras minúsculas: {qtd_minusculas}\n"
        f"Quantidade total de letras: {qtd_letras}\n"
        f"Quantidade de números: {qtd_numeros}\n"
        f"Quantidade total de caracteres: {qtd_total}"
    )

    # Exibe o resultado em uma caixa de mensagem
    messagebox.showinfo("Resultado da Análise", resultado)

# ---------------- CONSTRUÇÃO DA JANELA (Request) ---------------- #
# Criação da janela principal
janela = tk.Tk()
janela.title("Analisador de Texto")
janela.geometry("400x200")

# Rótulo explicativo
rotulo = tk.Label(janela, text="Digite algo:", font=("Arial", 12))
rotulo.pack(pady=10)

# Campo de entrada de texto (controle que será preenchido pelo usuário)
entrada = tk.Entry(janela, font=("Arial", 12), width=40)
entrada.pack()

# Botão para executar a análise
botao = tk.Button(janela, text="Analisar", font=("Arial", 12), command=analisar_texto)
botao.pack(pady=20)

# Inicia o loop da interface
janela.mainloop()
