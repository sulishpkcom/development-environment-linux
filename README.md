# Ubuntu Development Environment Setup Script

## Overview

This Bash script is designed to streamline the setup of development environments on Ubuntu-based systems. It provides an interactive menu-driven interface that empowers users to select from predefined development environments or create a custom environment tailored to their specific requirements. The script automates the installation and configuration of essential software components, simplifying the process of preparing a development environment for various programming needs.

## Features

### 1. **Node.js Development Environment**
- Installs Node.js and npm for JavaScript development.
- Sets up Git for version control.
- Installs MySQL Server for database management.
- Configures the Uncomplicated Firewall (UFW) for enhanced security.

### 2. **Apache Development Environment**
- Installs Apache2 as a web server.
- Sets up Git for version control.
- Installs PHP for server-side scripting.
- Adds PHP extensions for MySQL support.
- Installs phpMyAdmin for efficient database administration.
- Installs MySQL Server for comprehensive database management.
- Configures the Uncomplicated Firewall (UFW) for robust security measures.

### 3. **Custom Development Environment**
- Provides a highly customizable menu for selecting specific development tools and components.
- Options include Node.js, Apache2, Git, PHP, phpMyAdmin, MySQL Server, and UFW.
- Installs and configures the selected components, allowing users to create a tailored development environment that suits their project requirements.

### 4. **User Management**
- Offers the option to create a new user for MySQL and phpMyAdmin, strengthening access control and security.

## Usage

- Run the script in your terminal, and follow the interactive prompts to choose your desired development environment or customize it based on your specific needs.
- The script will automatically handle the installation and configuration of the selected components, simplifying the setup process.

**Note:** Ensure that you execute the script with administrative privileges (e.g., using `sudo`) to allow for package installation and system configuration.
