import express, { Application, Request, Response } from 'express';

const app: Application = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req: Request, res: Response) => {
  res.status(200).json({
    status: 200,
    message: 'Hello World'
  });
});

app.get('/health', (req: Request, res: Response) => {
  res.status(200).json({
    status: 200,
    message: 'OK, I\'m healthy',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  });
});

export default app;

