{% macro render(post) %}
  <article class="post">
    <header class="post-header">
      <h1 class="post-title">
        {% if is_home() %}
          <a class="post-link" href="{{ url_for(post.path) }}">{{ post.title }}</a>
        {% else %}
          {{ post.title }}
        {% endif %}
      </h1>

      <time class="post-time">
          {{ full_date(post.date, 'MMM DD YYYY') }}
      </time>
    </header>



    {% if is_home() %}
        <div class="post-excerpt">
            {% set excerpt = "" %}
            {% if post.description %}
              {% set excerpt = post.description %}
            {% elif post.excerpt %}
              {% set excerpt = post.excerpt %}
            {% endif %}

            {% if excerpt %}
              {{ excerpt }}
        </div>
            {% endif %}
          {% else %}
            <div class="post-content">
            {{ post.content }}
            </div>
          {% endif %}

    {% if not is_home() %}
      <footer class="post-footer">
		{% if post.tags and post.tags.length %}
		<div>
		  {% for tag in post.tags %}
      <span style="padding: 3px 5px; background-color: #f8f8f8; font-size: 13px">
			 <i class="fa fa-tag"></i>&nbsp<a href="{{ url_for(tag.path) }}">{{ tag.name }}</a>&nbsp
      </span>
      &nbsp
		  {% endfor %}
		</div>
		{% endif %}

        {# Post Pagination #}
        {% include "../_partial/pagination.swig" %}
        {% include "../_partial/comments.swig" %}
      </footer>
    {% endif %}
  </article>
{% endmacro %}
