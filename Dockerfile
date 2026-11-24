# Menggunakan base image Node.js versi 14
FROM node:14

# Menentukan working directory di dalam container
WORKDIR /app

# Menyalin seluruh source code ke working directory
COPY . .

# Mengatur production mode dan alamat host database MongoDB
ENV NODE_ENV=production DB_HOST=item-db

# Menginstal production dependencies dan membangun aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Membuka port 8080 untuk aplikasi
EXPOSE 8080

# Menjalankan aplikasi ketika container diluncurkan
CMD ["npm", "start"]
