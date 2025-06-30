#!/bin/bash

clear
# Cor roxa
purple='\033[0;35m'
reset='\033[0m'

# ASCII ART
echo -e "${purple}"
echo "███╗       ██╗    ██╗  ██╗™"
echo "████╗     ██║    ╚██╗██╔╝"
echo "██╔██╗   ██║      ╚███╔╝"
echo "██║╚██╗ ██║     ██ ╔██╗"
echo "██║  ╚████║   ██╔╝  ██╗"
echo "╚═╝  ╚═══╝   ╚═╝    ╚═╝"
echo ""
echo "  WELCOME TO NX 7ZIP UNLOCKER"
echo -e "${reset}"

# Solicita o caminho do arquivo
echo ""
echo "/storage/emulated/0/:"
read -p "/$/: " caminho

# Verifica se o arquivo existe
if [ ! -f "$caminho" ]; then
  echo -e "\n[ERRO] Arquivo não encontrado!"
  exit 1
fi

# Define senha padrão (uso pessoal)
senha="suaSenhaAqui" # <- Coloque sua senha aqui

# Cria pasta temporária
tmp="/data/data/com.termux/files/home/.NX_TMP"
mkdir -p "$tmp"

# Simulação de carregamento
echo -ne "\nExtraindo: "
barra="____________________"
for i in {1..20}; do
  sleep 0.1
  barra="${barra/_/█}"
  porcentagem=$((i * 5))
  echo -ne "\rExtraindo: $barra • $porcentagem%"
done
echo ""

# Tenta extrair com senha
echo -e "\nDescompactando arquivo..."
7z x -p"$senha" "$caminho" -o"$tmp" -y >/dev/null 2>&1

# Verifica se deu certo
if [ $? -ne 0 ]; then
  echo "[ERRO] Falha na extração. Senha incorreta ou arquivo inválido."
  rm -rf "$tmp"
  exit 1
fi

# Pergunta se quer mover para Download
echo -e "\nDOWNLOAD!? [Y]/[N]"
read -n 1 escolha
echo ""

if [[ "$escolha" == "Y" || "$escolha" == "y" ]]; then
  mv "$tmp"/* "/storage/emulated/0/Download/"
  echo "[✓] Arquivos movidos para Downloads com sucesso!"
else
  echo "[INFO] Os arquivos permanecem na pasta temporária: $tmp"
fi

echo -e "\nFim do processo. Obrigado por usar o NX 7ZIP UNLOCKER!"
