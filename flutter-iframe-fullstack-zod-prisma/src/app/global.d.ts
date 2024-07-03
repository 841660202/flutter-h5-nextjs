interface Window {
  fromFlutter: (message: string) => void;
  flutter_inappwebview: { callHandler: (method: string, message?: number | string) => void };
}
