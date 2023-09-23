#!/bin/bash

# Function to create a new user if it doesn't exist
create_user() {
    read -p "Enter a username for MySQL and phpMyAdmin: " username
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
    else
        sudo adduser "$username"
        sudo usermod -aG sudo "$username"
        echo "User '$username' created."
    fi
}

# Function to install and configure Node.js Development Environment
install_nodejs_env() {
    sudo apt-get update
    sudo apt-get install -y nodejs npm git mysql-server ufw
    sudo systemctl enable mysql
    sudo systemctl start mysql
    echo "Node.js Development Environment installed and configured."
}

# Function to install and configure Apache Development Environment
install_apache_env() {
    sudo apt-get update
    sudo apt-get install -y apache2 git php php-mysql phpmyadmin mysql-server ufw
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo systemctl enable mysql
    sudo systemctl start mysql
    echo "Apache Development Environment installed and configured."
}

# Function to install and configure Nginx Development Environment
install_nginx_env() {
    sudo apt-get update
    sudo apt-get install -y nginx git php php-fpm php-mysql phpmyadmin mysql-server ufw
    sudo systemctl enable nginx
    sudo systemctl start nginx
    sudo systemctl enable mysql
    sudo systemctl start mysql
    sudo systemctl enable php7.4-fpm
    sudo systemctl start php7.4-fpm
    echo "Nginx Development Environment installed and configured."
}

# Function to allow the user to select apps for the Custom Development Environment
install_custom_env() {
    selected_apps=()
    
    PS3="Select the apps you want for the Custom Development Environment (press Enter after each selection, 'Done' to finish): "
    options=("Node.js" "Apache" "Nginx" "Git" "PHP" "phpMyAdmin" "MySQL" "UFW" "Done")
    
    while true; do
        select opt in "${options[@]}"; do
            case $opt in
                "Node.js")
                    selected_apps+=("nodejs" "npm")
                    ;;
                "Apache")
                    selected_apps+=("apache2" "php" "php-mysql" "phpmyadmin" "mysql-server")
                    ;;
                "Nginx")
                    selected_apps+=("nginx" "php" "php-fpm" "php-mysql" "phpmyadmin" "mysql-server")
                    ;;
                "Git")
                    selected_apps+=("git")
                    ;;
                "PHP")
                    selected_apps+=("php" "php-mysql")
                    ;;
                "phpMyAdmin")
                    selected_apps+=("phpmyadmin")
                    ;;
                "MySQL")
                    selected_apps+=("mysql-server")
                    ;;
                "UFW")
                    selected_apps+=("ufw")
                    ;;
                "Done")
                    break 2
                    ;;
                *)
                    echo "Invalid selection."
                    ;;
            esac
            break
        done
    done

    # Install selected apps
    sudo apt-get update
    sudo apt-get install -y "${selected_apps[@]}"
    sudo systemctl enable mysql
    sudo systemctl start mysql

    # Enable and start the web server (Apache or Nginx)
    if [[ " ${selected_apps[@]} " =~ "apache2" || " ${selected_apps[@]} " =~ "nginx" ]]; then
        if [[ " ${selected_apps[@]} " =~ "apache2" ]]; then
            sudo systemctl enable apache2
            sudo systemctl start apache2
        fi
        if [[ " ${selected_apps[@]} " =~ "nginx" ]]; then
            sudo systemctl enable nginx
            sudo systemctl start nginx
            sudo systemctl enable php7.4-fpm
            sudo systemctl start php7.4-fpm
        fi
    fi

    echo "Custom Development Environment installed and configured."
}

# Display a custom credit text
display_credit_text() {
    echo -e "\n----------------------------------"
    echo "This script was built by Your Name"
    echo "----------------------------------"
    sleep 2s
}

# Main script
display_credit_text

create_user

echo "Select a development environment:"
select env in "Node.js Development Environment" "Apache Development Environment" "Nginx Development Environment" "Custom Development Environment" "Quit"
do
    case $env in
        "Node.js Development Environment")
            install_nodejs_env
            ;;
        "Apache Development Environment")
            install_apache_env
            ;;
        "Nginx Development Environment")
            install_nginx_env
            ;;
        "Custom Development Environment")
            install_custom_env
            ;;
        "Quit")
            break
            ;;
        *)
            echo "Invalid selection."
            ;;
    esac
done

echo "Development environment installation completed."
