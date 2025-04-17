let playerTab = null;

function openOrReuseTabWithChannel(url) {
  const fullUrl = new URL(url, window.location.origin).toString();

  if (!playerTab || playerTab.closed) {
    // ✅ 처음 열릴 때는 파라미터 포함된 URL로 열기
    playerTab = window.open(fullUrl, "myFixedPlayerTab");
  } else {
    // 🔁 이미 열려 있으면 메시지로 이동 명령
    const channel = new BroadcastChannel("player-control");
    channel.postMessage({ type: "navigate", url: fullUrl });
    playerTab.focus();
  }
}
