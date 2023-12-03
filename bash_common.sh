DEBUG=false

# ================================= #
# Fonctions d'affichage de messages
# ================================= #
print_error() {
    echo -e "\033[0;31m[!!!] $1\033[0m"
}

print_success() {
    echo -e "\033[0;32m[OK] $1\033[0m"
}

print_info() {
    echo -e "\033[0;34m[INFO] $1\033[0m"
}

print_additional_info() {
    echo -e "\033[0;33m[***] $1\033[0m"
}

# Fonction run_command
#
# Description :
#   Exécute une commande Bash spécifiée en tant qu'argument de la fonction.
#   Capture la sortie standard (stdout) et la sortie d'erreur (stderr) de la commande.
#   Affiche des informations de débogage si la variable DEBUG est définie à true.
#
# Utilisation :
#   run_command [commande]
#
# Paramètres :
#   - commande : La commande Bash à exécuter.
#
# Variables d'environnement :
#   - DEBUG : Si défini à true, affiche des informations de débogage.
#
# Retour :
#   - Succès (0) : Si la commande s'est exécutée avec succès.
#   - Échec (1) : Si la commande a échoué. Affiche la sortie d'erreur de la commande.
#
# Exemples d'utilisation :
#   run_command "ls -l"
#   run_command "echo 'Hello, World!'"
#
# Remarques :
#   - Utilise eval pour exécuter la commande passée en argument.
#   - Capture la sortie (stdout et stderr) de la commande pour l'affichage en cas d'échec.
#
run_command() {
    if [ "$DEBUG" = true ]; then
        echo "[*] Exécution de la commande: $@"
    fi
    # Exécute la commande et capture la sortie standard (stdout) et la sortie d'erreur (stderr)
    output=$(eval "$@" 2>&1)

    if [ $? -eq 0 ]; then
        # La commande a réussi, affiche la commande exécutée
        if [ "$DEBUG" = true ]; then
            echo "[*] Commande exécutée avec succès: $@"
        fi
        return 0
    else
        # La commande a échoué, affiche la commande exécutée
        echo "[!!!] La commande '$@' a échoué avec la sortie suivante:"
        # Affiche la sortie d'erreur de la commande
        print_error "$output"
        return 1
    fi
}