# Get the base image of Node version 16
FROM node:16

# Use the latest Playwright image that includes Node.js and browsers
FROM mcr.microsoft.com/playwright:focal AS base

# Set the work directory for the application
WORKDIR /app

# Copy the package.json and package-lock.json first to leverage Docker cache
COPY package.json package-lock.json /app/

# Install Node.js dependencies
RUN npm install

# Install Playwright and its dependencies, including Chrome
RUN npx playwright install --with-deps && \
    npx playwright install chrome

# Set the environment path to node_modules/.bin
ENV PATH=/app/node_modules/.bin:$PATH

# Stage 2: Application build
FROM base AS build

# Copy the rest of the application files



COPY src/ /app/src/


COPY playwright.config.ts /app/

COPY start_docker.sh /app/

COPY tests/ /app/tests/



# Stage 3: Final runtime image
FROM base AS runtime

# Install necessary system libraries for allure (if not included in the Playwright image)


# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Copy installed node_modules and Playwright browsers from the build stage
COPY --from=build /app /app

# Expose the port for the Allure report server


# Use the default command to start the application or the Playwright tests
CMD ["sh", "-c", "./start_docker.sh"]