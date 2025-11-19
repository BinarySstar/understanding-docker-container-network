import os
from fastapi import FastAPI, Request

app = FastAPI()


@app.get("/")
async def root(request: Request):
    container_name = os.getenv("CONTAINER_NAME", "Unknown Container")

    client_host = request.client.host
    client_port = request.client.port

    return {
        "response": f"I'm {container_name} ",
        "client_info": f"{client_host}:{client_port}"
    }
