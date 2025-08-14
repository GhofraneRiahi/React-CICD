# Étape 1 : Build de l'app React avec Vite
FROM node:20 AS build

# Définir le dossier de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le reste du code
COPY . .

# Run tests before building
RUN npm test

# Build de l'application pour production
RUN npm run build

# Étape 2 : Servir l'app avec Nginx
FROM nginx:alpine

# Copier le build de l'étape précédente vers Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande pour lancer Nginx
CMD ["nginx", "-g", "daemon off;"]