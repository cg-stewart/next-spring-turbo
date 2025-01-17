# Next.js + Spring Boot Monorepo with shadcn/ui

A full-stack monorepo template using Next.js, Spring Boot, and shadcn/ui, powered by Turborepo. This template provides a production-ready setup with AWS integration and automated deployments.

## Features

- 🏎️ **Turborepo** - High-performance build system
- ⚛️ **Next.js** - React framework with App Router
- ☕ **Spring Boot** - Java backend with Spring Cloud AWS
- 🎨 **shadcn/ui** - High-quality component system
- 🚀 **AWS Ready** - Configured for ECS Fargate, ECR, and Parameter Store
- 📦 **Monorepo Structure** - Optimized for full-stack development

## Prerequisites

- Node.js (>=20)
- PNPM (>=9.12.3)
- Java 17+
- Docker (for backend deployment)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/cg-stewart/next-spring-turbo
cd next-spring-turbo
```

2. Install dependencies:
```bash
pnpm install
```

3. Start development servers:
```bash
# Run both frontend and backend
pnpm dev:all

# Or use tmux split panes (requires tmux)
pnpm dev:tmux
```

## Development

### Frontend (Next.js)

The frontend application is in `apps/web`, built with Next.js and shadcn/ui.

#### Adding shadcn/ui Components

To add components, run at the root of your project:
```bash
pnpm dlx shadcn@latest add button -c apps/web
```

#### Using Components

Import components from the workspace:
```tsx
import { Button } from "@workspace/ui/components/ui/button";
```

### Backend (Spring Boot)

The backend application is in `apps/api`, built with Spring Boot and Spring Cloud AWS.

#### API Documentation
- Swagger UI: http://localhost:8080/swagger-ui.html
- API Docs: http://localhost:8080/v3/api-docs

## Project Structure

```
├── apps
│   ├── web                 # Next.js application
│   │   ├── src            # Frontend source code
│   │   └── package.json   # Frontend dependencies
│   └── api                # Spring Boot application
│       ├── src            # Backend source code
│       └── pom.xml        # Backend dependencies
├── packages               # Shared packages
├── .github
│   └── workflows         # GitHub Actions CI/CD
└── turbo.json            # Turborepo configuration
```

## Development Commands

```bash
# Start development servers
pnpm dev:all         # Run both frontend and backend
pnpm dev:tmux        # Run in tmux split panes
pnpm dev:web         # Run only frontend
pnpm dev:api         # Run only backend

# Building
pnpm build           # Build all applications

# Linting
pnpm lint           # Lint all applications
```

## Deployment

### Frontend
- Automatically deployed to Vercel
- Triggered on push to main branch
- Environment variables managed in Vercel dashboard

### Backend
- Deployed to AWS ECS Fargate via GitHub Actions
- Container images stored in Amazon ECR
- Configuration managed via AWS Parameter Store

### Setting Up Deployment Workflow

1. Create AWS resources:
```bash
# Create ECR repository
aws ecr create-repository \
    --repository-name your-app-name \
    --region your-region

# Create ECS cluster
aws ecs create-cluster \
    --cluster-name your-cluster

# Create log group
aws logs create-log-group \
    --log-group-name /ecs/your-app-name
```

2. Update the workflow configuration in `.github/workflows/backend-deploy.yml`:
```yaml
env:
  ECR_REPOSITORY: your-app-name    # Your ECR repository name
  ECS_SERVICE: your-service        # Your ECS service name
  ECS_CLUSTER: your-cluster        # Your ECS cluster name
  ECS_TASK_DEFINITION: your-task   # Your task definition name
```

3. Configure the task definition in `aws/task-definition.json`:
- Update `YOUR_ACCOUNT_ID`
- Update `YOUR_ECR_REPO_URI`
- Update `your-region`

4. Add Dockerfile to your Spring Boot application:
- Copy the provided Dockerfile to `apps/api/Dockerfile`
- Update any environment-specific configurations

#### Required AWS Setup
1. Create ECR repository
2. Set up ECS cluster and service
3. Configure Parameter Store variables
4. Set up IAM roles and policies

#### Required GitHub Secrets
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```

The deployment workflow will automatically:
- Build your Spring Boot application
- Create a Docker image
- Push to Amazon ECR
- Deploy to ECS Fargate
- Update the running service

For local testing of the Docker build:
```bash
cd apps/api
docker build -t your-app-name .
docker run -p 8080:8080 your-app-name
```

## Tailwind Configuration

The `tailwind.config.ts` and `globals.css` are pre-configured to work with shadcn/ui components. The configuration is shared across the monorepo through the workspace packages.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
