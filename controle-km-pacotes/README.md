# Controle de Rotas V3 (Supabase)

## Configuração
1. Crie um projeto no Supabase.
2. Cole Project URL e chave anon/public em `config.js` (nunca use service_role).
3. Execute `supabase.sql` no SQL Editor.
	Se o banco já estava configurado, execute também `make_route_km_optional.sql` no SQL Editor.
4. Ative Email e Google em Authentication > Providers; configure URLs de redirecionamento do Vercel e localhost.
5. Publique estes arquivos no Vercel como site estático.
6. Crie sua conta, crie um espaço e gere um código de convite. Sua esposa cria uma conta individual e usa o código.

Os dados ficam no banco Supabase e são compartilhados entre membros do espaço. Requer internet. Veja `supabase.sql` para tabelas, funções e políticas RLS.
