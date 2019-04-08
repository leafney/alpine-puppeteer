module.exports = {
  apps: [{
    name: 'node_app',
    script: './src/index.js',
    instances: 1,
    autorestart: true,
    watch: false,
    // watch: ["src"],
    // ignore_watch: ["node_modules"],
    max_memory_restart: '50M',
    log_date_format: 'YYYY-MM-DD HH:mm:ss',
    out_file: '/logs/puppet_out.log',
    error_file: '/logs/puppet_error.log',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],
};
