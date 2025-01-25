-- создаем витрину данных по модели Last Paid Click

with sessions_sorted as (
	select *
	from sessions s
	order by visitor_id, visit_date desc
)

select distinct
	ss.visitor_id,
	ss.visit_date,
	ss.source as utm_source,
	ss.medium as utm_medium,
	ss.campaign as utm_campaign,
	l.lead_id,
	l.created_at,
	l.amount,
	l.closing_reason,
	l.status_id
from sessions_sorted ss
left join leads l on ss.visitor_id = l.visitor_id
where ss.medium in ('cpc', 'cpm', 'cpa', 'youtube', 'cpp', 'tg', 'social')
order by
	amount desc nulls last,
	visit_date asc,
	utm_source asc,
	utm_medium asc,
	utm_campaign asc;
