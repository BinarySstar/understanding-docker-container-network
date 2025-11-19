from fastapi import FastAPI, Request

app = FastAPI()


@app.get("/")
async def root(request: Request):
    client_host = request.client.host
    client_port = request.client.port
    return {"response": f"Hello World~~ from {client_host}:{client_port}"}
