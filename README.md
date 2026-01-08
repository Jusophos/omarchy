# omarchy
Personal after install flavor for omarchy

## Requirements
- Freshly Installation of Omarchy
- Updated system
- (optional) fingerprint authentication for faster sudo

## Installation

### 1. Step
Clone this git repository to the freshly installed omarchy installation into the `~/.omarchy` folder

Command: `git clone https://github.com/Jusophos/omarchy.git ~/.omarchy`

### 2. Step
Execute the main installation file `install.sh`.

```bash
cd ~/.omarchy/install
./install.sh
```

### 3. Step
Authenticate and install ssh keys e.g. with 1password.

### 4. Step
Install the script build for after authentication: `install-after-auth.sh`

```bash
cd ~/.omarchy/install
./install-after-auth.sh

```

### 5. Step
If you want you can take a look into the extra folder for some options for installation. Each of the script has to be executed by your self.

Folder: `install/extras`

## Scripts
### `install.sh`
The main installation script to be executed after the installation.

### `install-after-auth.sh`
The installation script to be executed after git and ssh key authentication ( e.g. from 1password)

