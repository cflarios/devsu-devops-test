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

    // Test if the jwt key is correct
    test('should return 404 NOT FOUND without JWT', async () => {
        const response = await request(app).post('/DevOps')
            .send({ message: 'This is a Test', to: 'John', from: 'Jane', timeToLifeSec: 10 })
            .set('X-Parse-REST-API-Key', process.env.API_KEY)
            .set('X-JWT-KWY', 'wrong');
        expect(response.statusCode).toBe(404);
    });

    // Test if the api key is correct
    test('should return 404 NOT FOUND without APIKey', async () => {
        const response = await request(app).post('/DevOps')
            .send({ message: 'This is a Test', to: 'John', from: 'Jane', timeToLifeSec: 10 })
            .set('X-Parse-REST-API-Key', 'wrong')
            .set('X-JWT-KWY', process.env.JWT_SECRET);
        expect(response.statusCode).toBe(404);
    });

    // Test if the message is correct
    test('should return the correct message', async () => {
        const response = await request(app).post('/DevOps')
            .send({ message: 'This is a Test', to: 'John', from: 'Jane', timeToLifeSec: 10 })
            .set('X-Parse-REST-API-Key', process.env.API_KEY)
            .set('X-JWT-KWY', process.env.JWT_SECRET);
        expect(response.body.message).toBe('Hello John your message will be send');
    });

});