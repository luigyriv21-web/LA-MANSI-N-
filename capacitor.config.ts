import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.lamansion.casacreativa',
  appName: 'LA MANSIÓN',
  webDir: 'public',
  bundledWebRuntime: false,
  server: { androidScheme: 'https' }
};

export default config;
