import logging

import click


@click.group()
def cli():
    """Azure Form Recogniser CLI."""
    ...



if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    cli()
