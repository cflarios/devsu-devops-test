import app from '../src/app.js';
import request from 'supertest';

// Test if DevOps endpoint is working correctly
describe('POST /DevOps', () => {
    it('should return 200 OK', async () => {
        const response = await request(app).post('/DevOps')
            .send({ message: 'This is a Test', to: 'John', from: 'Jane', timeToLifeSec: 10 })
            .set('X-Parse-REST-API-Key', process.env.API_KEY)
            .set('X-JWT-KWY', process.env.JWT_SECRET);
        expect(response.statusCode).toBe(200);
    });
});