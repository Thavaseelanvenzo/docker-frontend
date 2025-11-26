# Stage 1: Base
FROM node:20-alpine AS base
WORKDIR /app

# Stage 2: Dependencies
FROM base AS dependencies
COPY frontend/package*.json ./
RUN npm ci && npm cache clean --force

# Stage 3: Development
FROM base AS development
COPY frontend/package*.json ./
RUN npm install
COPY frontend ./
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# Stage 4: Build
FROM base AS build
COPY frontend/package*.json ./
RUN npm ci
COPY frontend ./
RUN npm run build

# Stage 5: Production (Node server)
FROM node:20-alpine AS production

WORKDIR /app

# Copy the built files
COPY --from=build /app/dist ./dist

# Install a lightweight static server
RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]
