from whisperx import load_model, load_align_model, diarize
import requests
import torch
import os

def handler(event):
    audio_url = event['input'].get('audio_url')
    diarize_enabled = event['input'].get('diarization', True)
    speaker_labels = event['input'].get('speaker_labels', True)

    if not audio_url:
        return {"error": "Missing audio_url"}

    audio_path = "audio.wav"
    with requests.get(audio_url, stream=True) as r:
        with open(audio_path, "wb") as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)

    device = "cuda" if torch.cuda.is_available() else "cpu"

    model = load_model("medium", device=device)
    result = model.transcribe(audio_path)

    if diarize_enabled:
        diarize_segments = diarize(audio_path, result["segments"], model, return_speaker_labels=speaker_labels)
        result["segments"] = diarize_segments

    return {
        "status": "success",
        "segments": result["segments"]
    }

