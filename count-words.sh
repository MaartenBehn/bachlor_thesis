nix-shell -p pdfminer --run "pdf2txt main.pdf" | tr -d ' \n' | wc -c
