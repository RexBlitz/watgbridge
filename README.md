## Installation

- Make a supergroup (enable message history for new members) with topics enabled
- Add your bot in the group, make it an admin with permissions to `Manage topics`

- Install `git`, `gcc` and `golang`, `ffmpeg` , `imagemagick` (optional), on your system

sudo yum install -y git gcc golang ffmpeg

git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name

- Clone this repository anywhere and navigate to the cloned directory
- Run `go build`
- Copy `sample_config.yaml` to `config.yaml` and fill the values, there are comments to help you.

nano config.yml

go build -o watgbridge

- Execute the binary by running `./watgbridge`


- On first run, it will show QR code for logging into WhatsApp that can by scanned by the WhatsApp app in `Linked devices`
- It is recommended to restart the bot after every few hours becuase WhatsApp likes to disconnect a lot. So a sample Systemd service file has been provided

 (`watgbridge.service.sample`). Edit the `User` and `ExecStart` according to your setup:
    - If you do not have local bot API server, remove `tgbotapi.service` from the `After` key in `Unit` section.
    - This service file will restart the bot every 24 hours

sudo nano /etc/systemd/system/wt-bot.service (for edit)

sudo cp watg.service /etc/systemd/system (copy)

sudo systemctl daemon-reload

sudo systemctl restart watg.service


