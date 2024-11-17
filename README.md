## Task: Run an Nginx Container and Make It Accessible Through Your Browser

### Objective
- Launch an Nginx container.
- Access the Nginx welcome page through your browser using an Elastic IP.
- Enter the container and restart the Nginx service.

---

### Steps to Complete the Task

1. **Launch an Nginx Container**
   ```bash
   docker run -d --name nginx-container -p 80:80 nginx
   ```
   - The `-d` flag runs the container in detached mode.
   - The `--name` flag names the container `nginx-container`.
   - The `-p 80:80` maps port 80 of your host machine to port 80 of the container.

2. **Create a Temporary Elastic IP**
   - Log in to your AWS Management Console.
   - Go to the **EC2 Dashboard** > **Elastic IPs**.
   - Allocate a new Elastic IP and associate it with your EC2 instance running Docker.

3. **Access the Nginx Welcome Page**
   - Open your browser.
   - Enter the Elastic IP you associated with your EC2 instance.
   - You should see the default Nginx welcome page.

4. **Enter the Running Container**
   ```bash
   docker exec -it nginx-container bash
   ```
   - The `exec` command allows you to run a shell inside the container.

5. **Restart the Nginx Service Inside the Container**
   ```bash
   service nginx restart
   ```
   - This command restarts the Nginx service running in the container.

6. **Release the Elastic IP (Optional)**
   - Once you're done, go back to the AWS Management Console.
   - Disassociate and release the Elastic IP to avoid unnecessary charges.

---

### Example Commands

#### Launch the Nginx Container
```bash
docker run -d --name nginx-container -p 80:80 nginx
```

#### Associate Elastic IP
- AWS Console > EC2 Dashboard > Elastic IPs > Allocate Elastic IP > Associate with EC2 instance.

#### Enter the Container and Restart Nginx
```bash
docker exec -it nginx-container bash
service nginx restart
```

#### Release Elastic IP (Optional)
- AWS Console > EC2 Dashboard > Elastic IPs > Disassociate > Release.

![Nginx Welcome Page](./Nginx%20welcome%20page.jpeg)
