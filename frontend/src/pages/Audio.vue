/* eslint-disable */
<template>
<div class="audio-recording-container">
    <h1 class="title"><b>Welcome to ChAI</b><br>Eating the world, one bite at a time.</h1>
    <h2 class="title">Tell us what you would like to eat and we find it for you! </h2>
    <h6 class="description-text"> Don't forget to include your taste on food, specific diets (vegetarian, high protein content, etc), which ingredients you would like, which you have at your disposal. Be as specific as you can be, the more specific the better! </h6>
    <i class="start-recording-button fa fa-microphone" aria-hidden="true"></i>
    <div class="recording-contorl-buttons-container hide">
        <i class="cancel-recording-button fa fa-times-circle-o" aria-hidden="true"></i>
        <div class="recording-elapsed-time">
            <i class="red-recording-dot fa fa-circle" aria-hidden="true"></i>
            <p class="elapsed-time"></p>
        </div>
        <i class="stop-recording-button fa fa-stop-circle-o" aria-hidden="true"></i>
    </div>
    <div class="text-indication-of-audio-playing-container">
        <p class="text-indication-of-audio-playing hide">Audio is playing while we process it<span>.</span><span>.</span><span>.</span></p>
    </div>
</div>
<div class="transcription-container hide">
    <h3 class="title-transcript">This is what we hear:</h3>
    <p class="transcription-text"></p>
</div>
<div class="container-cards-recipes">
</div>
<div class="container-cards-restaurants">
</div>
<div class="overlay hide">
    <div class="browser-not-supporting-audio-recording-box">
        <p>To record audio, use browsers like Chrome and Firefox that support audio recording.</p>
        <button type="button" class="close-browser-not-supported-box">Ok.</button>
    </div>
</div>
<audio controls class="audio-element hide">
</audio>
</template>
