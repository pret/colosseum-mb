#include "global.h"
#include "gflib/sound.h"

static u8 sIsSoundVSyncPaused;
static bool8 sIsSoundVsync;

void InitSound(void)
{
    sIsSoundVSyncPaused = 0;
    sIsSoundVsync = FALSE;
    m4aSoundInit();
}

void PauseSoundVSync(void)
{
    sIsSoundVSyncPaused = 1;
    sIsSoundVsync = FALSE;
}

bool32 EnableSoundVSync(u32 enable)
{
    if (enable && sIsSoundVSyncPaused)
        sIsSoundVsync = TRUE;

    return sIsSoundVsync;
}

void PlaySE(u16 song)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    MPlayStart(mPlayInfo, gSongTable[song].header);
    m4aMPlayImmInit(mPlayInfo);
}

void UNUSED StopSE(u16 song)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayStop(mPlayInfo);
}

void UNUSED StopAllSound(void)
{
    m4aMPlayAllStop();
}

bool8 UNUSED ReturnTrue(void)
{
    return TRUE;
}

void UNUSED FadeOutSE(u16 song, u16 _speed)
{
    struct MusicPlayerInfo * mPlayInfo;
    u16 speed = _speed >> 4;

    if (speed == 0)
        speed = 1;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayFadeOut(mPlayInfo, speed);
}

void UNUSED SetSEVolume(u16 song, u16 volume)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayVolumeControl(mPlayInfo, 0xFF, volume);
}

void UNUSED SetSETempo(u16 song, u16 tempo)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayTempoControl(mPlayInfo, tempo);
}

void UNUSED SetSEPitch(u16 song, s16 pitch)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayPitchControl(mPlayInfo, 0xFF, pitch);
}

void SoundVSyncOff(void)
{
    sIsSoundVsync = FALSE;
    m4aSoundVSyncOff();
}

void SoundVSyncOn(void)
{
    m4aSoundVSyncOn();
    sIsSoundVsync = TRUE;
}
