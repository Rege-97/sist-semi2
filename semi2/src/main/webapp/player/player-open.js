
let playerTab = null;

function openOrReuseTabWithChannel(url) {
  const fullUrl = new URL(url, window.location.origin).toString();

  if (!playerTab || playerTab.closed) {
    playerTab = window.open("/semi2/player/player.jsp", "myFixedPlayerTab");
    // 첫 오픈 시는 delay 줘야 로딩되고 난 뒤 메시지 받음
    setTimeout(function() {
      const channel = new BroadcastChannel("player-control");
      channel.postMessage({ type: "navigate", url: fullUrl });
    }, 500);
  } else {
    // 이미 열려 있으면 바로 메시지 전달
    const channel = new BroadcastChannel("player-control");
    channel.postMessage({ type: "navigate", url: fullUrl });
    playerTab.focus();
  }
}
